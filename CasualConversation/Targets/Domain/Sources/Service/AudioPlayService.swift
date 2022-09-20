//
//  AudioPlayService.swift
//  Domain
//
//  Created by Yongwoo Marco on 2022/08/16.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common

import AVFAudio

public protocol CCPlayer {
	var isPlayingPublisher: Published<Bool>.Publisher { get }
	var currentTimePublisher: Published<TimeInterval>.Publisher { get }
	var durationPublisher: Published<TimeInterval>.Publisher { get }
	func stopTrackingCurrentTime()
	func setupPlaying(filePath: URL, completion: (CCError?) -> Void)
	func startPlaying()
	func pausePlaying()
	func finishPlaying()
	func seek(to time: Double)
	func changePlayingRate(to value: Float)
}

public protocol RecordManagable {
	func removeRecordFile(from filePath: URL, completion: (CCError?) -> Void)
}

public final class AudioPlayService: NSObject, Dependency {
	
	public struct Dependency {
		let dataController: RecordDataControllerProtocol
		
		public init(dataController: RecordDataControllerProtocol) {
			self.dataController = dataController
		}
	}
	
	public var dependency: Dependency
	
	private var audioPlayer: AVAudioPlayer? {
		willSet {
			if newValue == nil { self.progressTimer?.invalidate() }
		}
	}
	private var progressTimer: Timer?
	
	@Published var isPlaying: Bool = false {
		didSet {
			if !isPlaying { self.progressTimer?.invalidate() }
		}
	}
	@Published var duration: TimeInterval = .zero
	@Published var currentTime: TimeInterval = .zero
	
	public init(dependency: Dependency) {
		self.dependency = dependency
		
		super.init()
		setupNotificationCenter()
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	private func setupNotificationCenter() {
		NotificationCenter.default
			.addObserver(self,
						 selector: #selector(handleRouteChange),
						 name: AVAudioSession.routeChangeNotification,
						 object: nil)
		NotificationCenter.default
			.addObserver(self,
						 selector: #selector(handleInteruption),
						 name: AVAudioSession.interruptionNotification,
						 object: nil)
	}
	
	@objc func handleRouteChange(notification: Notification) {
		guard let info = notification.userInfo,
			  let rawValue = info[AVAudioSessionRouteChangeReasonKey] as? UInt else { return }
		guard let reson = AVAudioSession.RouteChangeReason(rawValue: rawValue) else { return }
		switch reson {
		case .unknown:						break
		case .newDeviceAvailable:			break
		case .oldDeviceUnavailable:			handleWhenOldDeviceUnavailable(info: info)
		case .categoryChange:				break
		case .override:						break
		case .wakeFromSleep:				break
		case .noSuitableRouteForCategory:	break
		case .routeConfigurationChange:		break
		@unknown default:					break
		}
	}
	
	private func handleWhenOldDeviceUnavailable(info: [AnyHashable : Any]) {
		guard let previousRoute = info[AVAudioSessionRouteChangeReasonKey] as? AVAudioSessionRouteDescription,
			  let previousOutput = previousRoute.outputs.first else { return }
		if previousOutput.portType == .headphones {
			if isPlaying {
				pausePlaying()
			}
		}
	}
	
	@objc func handleInteruption(notification: Notification) {
		guard let info = notification.userInfo,
			  let rawValue = info[AVAudioSessionInterruptionTypeKey] as? UInt else { return }
		guard let type = AVAudioSession.InterruptionType(rawValue: rawValue) else { return }
		switch type {
		case .began:
			if isPlaying {
				pausePlaying()
			}
		case .ended:
			guard let rawValue = info[AVAudioSessionInterruptionOptionKey] as? UInt else { return }
			let options = AVAudioSession.InterruptionOptions(rawValue: rawValue)
			if options == .shouldResume {
				// restart audio or restart recording
			}
		@unknown default:
			break
		}
	}
	
	private func makeAudioPlayer(by filePath: URL) -> AVAudioPlayer? {
		guard let data = dependency.dataController.requestRecordData(from: filePath) else {
			CCError.log.append(.audioServiceFailed(reason: .fileURLPathInvalidated))
			return nil
		}
		do {
			return try AVAudioPlayer(data: data) // Test FileType 수정필요
		} catch {
			CCError.log.append(.audioServiceFailed(reason: .fileBindingFailure))
			return nil
		}
	}
	
	private func startTrakingCurrentTime() {
		progressTimer = Timer.scheduledTimer(
			timeInterval: 0.1,
			target: self,
			selector: #selector(updateRealTimeValues),
			userInfo: nil,
			repeats: true
		)
	}
	
	@objc private func updateRealTimeValues() {
		self.currentTime = audioPlayer?.currentTime ?? 0
	}
	
}

extension AudioPlayService: CCPlayer {
	
	public var isPlayingPublisher: Published<Bool>.Publisher { $isPlaying }
	public var durationPublisher: Published<TimeInterval>.Publisher { $duration }
	public var currentTimePublisher: Published<TimeInterval>.Publisher { $currentTime }
	
	public func stopTrackingCurrentTime() {
		self.progressTimer?.invalidate()
	}
	
	public func setupPlaying(filePath: URL, completion: (CCError?) -> Void) {
		guard let audioPlayer = makeAudioPlayer(by: filePath) else {
			completion(.audioServiceFailed(reason: .fileBindingFailure))
			return
		}
		print(filePath)
		audioPlayer.enableRate = true
		audioPlayer.numberOfLoops = 0
		audioPlayer.volume = 1.0
		audioPlayer.delegate = self
		self.duration = audioPlayer.duration
		guard audioPlayer.prepareToPlay() else {
			completion(.audioServiceFailed(reason: .preparedFailure))
			return
		}
		self.audioPlayer = audioPlayer
		completion(nil)
	}
	
	public func startPlaying() {
		audioPlayer?.play()
		self.isPlaying = true
		self.startTrakingCurrentTime()
	}
	
	public func pausePlaying() {
		self.audioPlayer?.pause()
		self.isPlaying = false
	}
	
	public func finishPlaying() {
		if isPlaying {
			self.audioPlayer?.stop()
			self.isPlaying = false
		}
		self.audioPlayer = nil
		self.duration = .zero
		self.currentTime = .zero
	}
	
	public func seek(to time: Double) {
		var seekPosition = time
		
		if seekPosition < 0 {
			seekPosition = 0
		} else if seekPosition > duration {
			seekPosition = duration
		}
		
		if isPlaying { self.audioPlayer?.stop() }
		self.audioPlayer?.currentTime = seekPosition
		if isPlaying {
			self.audioPlayer?.play()
			self.startTrakingCurrentTime()
		}
	}
	
	public func changePlayingRate(to value: Float) {
		self.audioPlayer?.rate = value
	}
	
}

extension AudioPlayService: RecordManagable {

	public func removeRecordFile(from filePath: URL, completion: (CCError?) -> Void) {
		self.dependency.dataController.deleteRecordData(from: filePath, completion: completion)
	}
	
}

extension AudioPlayService: AVAudioPlayerDelegate {
	
	public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
		self.isPlaying = false
		self.audioPlayer?.stop()
		self.currentTime = .zero
	}
	
}
