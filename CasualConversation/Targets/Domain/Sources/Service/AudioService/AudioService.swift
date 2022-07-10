//
//  RecordService.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common

import Foundation
import AVFoundation

public protocol AudioPlayable {
	func playAudio(from filePath: URL)
	func stopPlaying()
}

public protocol AudioRecordable {
	func setupRecorder(suffix filePath: String)
	func startRecording()
	func pauseRecording()
	func stopRecording() -> URL
}

public protocol AudioServiceProtocol: AudioPlayable, AudioRecordable { }

public final class AudioService: NSObject, Dependency, ObservableObject {
	
	@Published public var status: AudioStatus = .stopped
	
	public var dependency: Dependency
	
	private var recorder: AudioRecorder?
	private var player: AudioPlayer?
	
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
			status = .pause
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
			status = .pause
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
	public func setupRecorder(suffix filePath: String) {
		let newFilePath = dependency.repository.storagePath.appendingPathComponent(filePath)
		guard let newRecorder = AudioRecorder.makeRecorder(from: newFilePath) else {
			print("\(#function) 해당 filePath에 오디오 파일이 없습니다")
			return
		}
		recorder = newRecorder
		recorder?.setupRecorder(delegate: self)
	}
	
	public func startRecording() {
		recorder?.startRecording()
		status = .recording
	}
	
	public func pauseRecording() {
		recorder?.pauseRecording()
		status = .pause
	}
	
	public func stopRecording() -> URL {
		let filePath = recorder?.stopRecording() ?? URL(string: "")!
		status = .stopped
		recorder = nil
		return filePath
	}
	
	public func recordingCurrentTime() -> TimeInterval {
		return recorder?.currentTime ?? 0
	}
	
}

extension AudioService {
	// MARK: - AudioPlayable
	public func playAudio(from filePath: URL) {
		guard let newplayer = AudioPlayer.makePlayer(from: filePath) else {
			print("\(#function) 해당 filePath에 오디오 파일이 없습니다")
			return
		}
		player = newplayer
		player?.setupPlayer(delegate: self)
		player?.playback()
		status = .playing
	}
	
	public func pausePlaying() {
		player?.pausePlaying()
		status = .pause
	}
	
	public func stopPlaying() {
		player?.stopPlaying()
		status = .stopped
	}
	
	public func playingCurrentTime() -> TimeInterval {
		return player?.currentTime ?? 0
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
