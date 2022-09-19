//
//  AudioRecordService.swift
//  Domain
//
//  Created by Yongwoo Marco on 2022/08/16.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common

import AVFAudio

public protocol CCRecorder {
	var isRecordingPublisher: Published<Bool>.Publisher { get }
	var currentTimePublisher: Published<TimeInterval>.Publisher { get }
	func setupRecorder(completion: (CCError?) -> Void)
	func startRecording()
	func pauseRecording()
	func stopRecording(completion: (Result<URL, CCError>) -> Void)
	func finishRecording(isCancel: Bool)
	func permission(completion: @escaping (Bool) -> Void)
}

public final class AudioRecordService: NSObject, Dependency {
	
	public struct Dependency {
		let dataController: RecordDataControllerProtocol
		
		public init(dataController: RecordDataControllerProtocol) {
			self.dataController = dataController
		}
	}
	
	public var dependency: Dependency
	
	private var audioRecorder: AVAudioRecorder? {
		willSet {
			if newValue == nil {
				self.stopTrackingCurrentTime()
			}
		}
	}
	private var progressTimer: Timer?
	
	@Published var isRecording: Bool = false
	@Published public var currentTime: TimeInterval = .zero
		
	public init(dependency: Dependency) {
		self.dependency = dependency
		
		super.init()
		setupNotificationCenter()
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	private func setupNotificationCenter() {
//		NotificationCenter.default.addObserver(self,
//											   selector: #selector(handleRouteChange),
//											   name: AVAudioSession.routeChangeNotification,
//											   object: nil)
		NotificationCenter.default.addObserver(self,
											   selector: #selector(handleInteruption),
											   name: AVAudioSession.interruptionNotification,
											   object: nil)
	}
	
//	@objc func handleRouteChange(notification: Notification) {
//		guard let info = notification.userInfo,
//			  let rawValue = info[AVAudioSessionRouteChangeReasonKey] as? UInt else { return }
//		guard let reson = AVAudioSession.RouteChangeReason(rawValue: rawValue) else { return }
//		switch reson {
//		case .unknown:						break
//		case .newDeviceAvailable:			break
//		case .oldDeviceUnavailable:			handleWhenOldDeviceUnavailable(info: info)
//		case .categoryChange:				break
//		case .override:						break
//		case .wakeFromSleep:				break
//		case .noSuitableRouteForCategory:	break
//		case .routeConfigurationChange:		break
//		@unknown default:					break
//		}
//	}
	
//	private func handleWhenOldDeviceUnavailable(info: [AnyHashable : Any]) {
//		guard let previousRoute = info[AVAudioSessionRouteChangeReasonKey] as? AVAudioSessionRouteDescription,
//			  let previousOutput = previousRoute.outputs.first else { return }
//		if previousOutput.portType == .headphones {
//			if status == .playing {
//				pausePlaying()
//				status = .paused
//			}
//		}
//	}
	
	@objc func handleInteruption(notification: Notification) {
		guard let info = notification.userInfo,
			  let rawValue = info[AVAudioSessionInterruptionTypeKey] as? UInt else { return }
		guard let type = AVAudioSession.InterruptionType(rawValue: rawValue) else { return }
		switch type {
		case .began:
			if isRecording {
				pauseRecording()
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
	
	private func makeAudioRecorder() -> AVAudioRecorder? {
		let newFilePath = dependency.dataController.requestNewFilePath()
//		let recordSettings: [String: Any] = [
//			AVFormatIDKey: Int(kAudioFormatLinearPCM),
//			AVSampleRateKey: 44100.0,
//			AVNumberOfChannelsKey: 1,
//			AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//		]
		let recordSettings: [String: Any] = [
			AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
			AVSampleRateKey: 44100.0,
			AVNumberOfChannelsKey: 1,
			AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
		]
		do {
			let recorder = try AVAudioRecorder(url: newFilePath, settings: recordSettings)
			return recorder
		} catch {
			CCError.log.append(.catchError(error))
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
		self.currentTime = audioRecorder?.currentTime ?? 0
	}
	
	private func stopTrackingCurrentTime() {
		self.progressTimer?.invalidate()
	}
	
}

extension AudioRecordService: CCRecorder {

	public var isRecordingPublisher: Published<Bool>.Publisher { $isRecording }
	public var currentTimePublisher: Published<TimeInterval>.Publisher { $currentTime }
	
	public func setupRecorder(completion: (CCError?) -> Void) {
		guard let audioRecorder = makeAudioRecorder() else {
			completion(.audioServiceFailed(reason: .bindingFailure))
			return
		}
		audioRecorder.delegate = self
		guard audioRecorder.prepareToRecord() else {
			completion(.audioServiceFailed(reason: .preparedFailure))
			return
		}
		self.audioRecorder = audioRecorder
		completion(nil)
	}
	
	public func startRecording() {
		while let recorder = self.audioRecorder {
			if recorder.record() {
				self.isRecording = true
				self.startTrakingCurrentTime()
				break
			}
		}
	}
	
	public func pauseRecording() {
		self.audioRecorder?.pause()
		self.isRecording = false
		self.stopTrackingCurrentTime()
	}
	
	public func stopRecording(completion: (Result<URL, CCError>) -> Void) {
		self.audioRecorder?.stop()
		self.isRecording = false
		guard let savedFilePath = audioRecorder?.url else {
			completion(.failure(.audioServiceFailed(reason: .fileURLPathSavedFailure)))
			return
		}
		completion(.success(savedFilePath))
	}
	
	public func finishRecording(isCancel: Bool) {
		if isRecording { self.audioRecorder?.stop() }
		if isCancel { self.audioRecorder?.deleteRecording() }
		self.isRecording = false
		self.audioRecorder = nil
		self.currentTime = 0.0
	}
	
	public func permission(completion: @escaping (Bool) -> Void) {
		let session = AVAudioSession.sharedInstance()
		switch session.recordPermission {
		case .denied:
			completion(false)
		case .undetermined:
			session.requestRecordPermission(completion)
		case .granted:
			completion(true)
		@unknown default:
			fatalError("Check AVAudioSession update")
		}
	}
	
}
 
extension AudioRecordService: AVAudioRecorderDelegate {
	
	public func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		self.isRecording = false // TODO: 해당 상황 고민하기 (메모리 크기 등)
	}
	
}
