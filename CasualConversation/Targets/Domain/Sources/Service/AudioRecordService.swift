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
	var status: AudioStatus { get }
	var currentRecordingTime: TimeInterval? { get }
	func setupRecorder(completion: (CCError?) -> Void)
	func startRecording(completion: (CCError?) -> Void)
	func pauseRecording()
	func stopRecording(completion: (Result<URL, CCError>) -> Void)
}

public final class AudioRecordService: NSObject, Dependency {
	
	@Published public var status: AudioStatus = .stopped
	
	public struct Dependency {
		let dataController: RecordDataControllerProtocol
		
		public init(dataController: RecordDataControllerProtocol) {
			self.dataController = dataController
		}
	}
	
	public var dependency: Dependency
	
	private var audioRecorder: AudioRecorderProtocol?
		
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
			if status == .recording {
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

extension AudioRecordService: AVAudioRecorderDelegate {
	
	public func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		status = .stopped
	}
	
}
  
extension AudioRecordService: CCRecorder {
	
	public var currentRecordingTime: TimeInterval? {
		self.audioRecorder?.currentTime
	}
	
	public func setupRecorder(completion: (CCError?) -> Void) {
		guard let newRecorder = dependency.dataController.makeAudioRecorder() else {
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
 


