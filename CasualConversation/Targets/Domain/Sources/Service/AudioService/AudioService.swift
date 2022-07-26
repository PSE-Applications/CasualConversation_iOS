//
//  RecordService.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common

import Foundation
import AVFAudio

public protocol AudioPlayable {
	var status: AudioStatus { get }
	var currentPlayingTime: TimeInterval? { get }
	func setupPlaying(from filePath: URL, completion: (CCError?) -> Void)
	func startPlaying(completion: (CCError?) -> Void)
	func pausePlaying()
	func stopPlaying()
	func finishPlaying()
}

public protocol AudioRecordable {
	var status: AudioStatus { get }
	var currentRecordingTime: TimeInterval? { get }
	func setupRecorder(completion: (CCError?) -> Void)
	func startRecording(completion: (CCError?) -> Void)
	func pauseRecording()
	func stopRecording(completion: (Result<URL, CCError>) -> Void)
}

public protocol AudioServiceProtocol: AudioPlayable, AudioRecordable { }

public final class AudioService: NSObject, Dependency, ObservableObject {
	
	@Published public var status: AudioStatus = .stopped
	
	public var dependency: Dependency
	
	private var audioRecorder: AudioRecorderProtocol?
	private var audioPlayer: AudioPlayerProtocol?
		
	public struct Dependency {
		let repository: RecordRepositoryProtocol
		
		public init(repository: RecordRepositoryProtocol) {
			self.repository = repository
		}
	}
	
	public init(dependency: Dependency) {
		self.dependency = dependency
		
		super.init()
		setupNotificationCenter()
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	private func setupNotificationCenter() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(handleRouteChange),
											   name: AVAudioSession.routeChangeNotification,
											   object: nil)
		NotificationCenter.default.addObserver(self,
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
			if status == .playing {
				pausePlaying()
				status = .paused
			}
		}
	}
	
	@objc func handleInteruption(notification: Notification) {
		guard let info = notification.userInfo,
			  let rawValue = info[AVAudioSessionInterruptionTypeKey] as? UInt else { return }
		guard let type = AVAudioSession.InterruptionType(rawValue: rawValue) else { return }
		switch type {
		case .began:
			if status == .playing {
				pausePlaying()
			} else if status == .recording {
				pauseRecording()
			}
			status = .paused
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
	
}

// MARK: - AudioRecodable
extension AudioService: AudioServiceProtocol {
	
	public var currentRecordingTime: TimeInterval? {
		self.audioRecorder?.currentTime
	}
	
	public func setupRecorder(completion: (CCError?) -> Void) {
		guard let newRecorder = dependency.repository.makeAudioRecorder() else {
			completion(.audioServiceFailed(reason: .bindingFailure))
			return
		}
		self.audioRecorder = newRecorder
		self.audioRecorder?.delegate = self
		guard let isPreparedToRecord = self.audioRecorder?.prepareToRecord() else {
			completion(.audioServiceFailed(reason: .bindingFailure))
			return
		}
		guard isPreparedToRecord else {
			completion(.audioServiceFailed(reason: .preparedFailure))
			return
		}
		completion(nil)
	}
	
	public func startRecording(completion: (CCError?) -> Void) {
		guard let isRecording = self.audioRecorder?.record() else {
			completion(.audioServiceFailed(reason: .bindingFailure))
			return
		}
		status = isRecording ? .recording : .stopped
		guard isRecording else {
			completion(.audioServiceFailed(reason: .startedFailure))
			return
		}
		completion(nil)
	}
	
	public func pauseRecording() {
		self.audioRecorder?.pause()
		status = .paused
	}
	
	public func stopRecording(completion: (Result<URL, CCError>) -> Void) {
		defer { self.audioRecorder = nil }
		self.audioRecorder?.stop()
		status = .stopped
		guard let savedFilePath = audioRecorder?.url else {
			completion(.failure(.audioServiceFailed(reason: .fileURLPathSavedFailure)))
			return
		}
		completion(.success(savedFilePath))
	}
	
}

// MARK: - AudioPlayable
extension AudioService {

	public var currentPlayingTime: TimeInterval? {
		self.audioPlayer?.currentTime
	}
	
	public func setupPlaying(from filePath: URL, completion: (CCError?) -> Void) {
		guard let newplayer = dependency.repository.makeAudioPlayer(from: filePath) else {
			completion(.audioServiceFailed(reason: .bindingFailure))
			return
		}
		self.audioPlayer = newplayer
		self.audioPlayer?.delegate = self
		guard let isPreparedToPlay = self.audioPlayer?.prepareToPlay() else {
			completion(.audioServiceFailed(reason: .bindingFailure))
			return
		}
		guard isPreparedToPlay else {
			completion(.audioServiceFailed(reason: .preparedFailure))
			return
		}
		completion(nil)
	}
	
	public func startPlaying(completion: (CCError?) -> Void) {
		guard let isPlaying = self.audioPlayer?.play() else {
			completion(.audioServiceFailed(reason: .bindingFailure))
			return
		}
		status = isPlaying ? .playing : .stopped
		guard isPlaying else {
			completion(.audioServiceFailed(reason: .preparedFailure))
			return
		}
		completion(nil)
	}
	
	public func pausePlaying() {
		self.audioPlayer?.pause()
		status = .paused
	}
	
	public func stopPlaying() {
		self.audioPlayer?.stop()
		status = .stopped
	}
	
	public func finishPlaying() {
		self.audioPlayer = nil
	}
	
}

extension AudioService: AVAudioRecorderDelegate {
	
	public func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		status = .stopped
	}
	
}

extension AudioService: AVAudioPlayerDelegate {
	
	public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
		status = .stopped
	}
	
}
