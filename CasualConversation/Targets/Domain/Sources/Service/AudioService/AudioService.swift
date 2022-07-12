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
	func setupPlaying(from filePath: URL)
	func playAudio()
	func stopPlaying()
}

public protocol AudioRecordable {
	func setupRecorder()
	func startRecording()
	func pauseRecording()
	func stopRecording() -> URL?
}

public protocol AudioServiceProtocol: AudioPlayable, AudioRecordable { }

public final class AudioService: NSObject, Dependency, ObservableObject {
	
	@Published public var status: AudioStatus = .stopped
	
	public var dependency: Dependency
	
	private var audioRecorder: AudioRecorderProtocol?
	private var audioPlayer: AudioPlayerProtocol?
	
//	private let meterTable = MeterTable(tableSize: 100)
	
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
		NotificationCenter.default
			.addObserver(self,
						 selector: #selector(handleRouteChange),
						 name: AVAudioSession.routeChangeNotification,
						 object: nil
			)
		NotificationCenter.default
			.addObserver(self,
						 selector: #selector(handleInteruption),
						 name: AVAudioSession.interruptionNotification,
						 object: nil
			)
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
			}
//				else if status == .recording {
//					stopRecording()
//				}
			status = .paused
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

extension AudioService: AudioServiceProtocol {

	// MARK: - AudioRecodable
	public func setupRecorder() {
		guard let newRecorder = dependency.repository.makeAudioRecorder() else {
			print("\(#function) 해당 filePath에 오디오 파일이 없습니다")
			return
		}
		self.audioRecorder = newRecorder
		self.audioRecorder?.delegate = self
	}
	
	public func startRecording() {
		self.audioRecorder?.record()
		status = .recording
	}
	
	public func pauseRecording() {
		self.audioRecorder?.pause()
		status = .paused
	}
	
	public func stopRecording() -> URL? {
		self.audioRecorder?.stop()
		let savedFilePath = audioRecorder?.url
		self.audioRecorder = nil
		status = .stopped
		return savedFilePath
	}
	
	public func recordingCurrentTime() -> TimeInterval {
		return audioRecorder?.currentTime ?? 0
	}
	
}

extension AudioService {
	
	// MARK: - AudioPlayable
	public func setupPlaying(from filePath: URL) {
		guard let newplayer = dependency.repository.makeAudioPlayer(from: filePath) else {
			print("\(#function) 해당 filePath에 오디오 파일이 없습니다")
			return
		}
		audioPlayer = newplayer
		audioPlayer?.delegate = self
	}
	
	public func playAudio() {
		if let audioPlayer = audioPlayer {
			let isPlaying = audioPlayer.play()
			status = isPlaying ? .playing : .stopped
		} else {
			
		}
	}
	
	public func pausePlaying() {
		audioPlayer?.pause()
		status = .paused
	}
	
	public func stopPlaying() {
		audioPlayer?.stop()
		status = .stopped
	}
	
	public func playingCurrentTime() -> TimeInterval {
		return audioPlayer?.currentTime ?? 0
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
