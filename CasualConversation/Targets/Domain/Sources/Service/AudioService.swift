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

public protocol RecordServiceProtocol {
	// Recorder Features
	func setupRecorder()
	func startRecording()
//	func pauseRecording()
	func stopRecording()
	
	// Player Features
	func playAudio(from filePath: URL)
	func stopPlaying()
}

public final class AudioService: NSObject, Dependency, ObservableObject {
	
	@Published var status: AudioStatus = .stopped
	
	public var dependency: Dependency
	private var audioRecorder: AVAudioRecorder?
	private var audioPlayer: AVAudioPlayer?
	private var filePath: URL {
		let fileManager = FileManager.default
		let tempDir = fileManager.temporaryDirectory
		let filePath = "TempMemo.caf" // 매번 생성해야함.
		return tempDir.appendingPathComponent(filePath)
	}
	
	public struct Dependency {
		let repository: RecordRepositoryProtocol
		
		public init(repository: RecordRepositoryProtocol) {
			self.repository = repository
		}
	}
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}

}

extension AudioService: RecordServiceProtocol {
	
	public func setupRecorder() {
		let recordSettings: [String: Any] = [
			AVFormatIDKey: Int(kAudioFormatLinearPCM),
			AVSampleRateKey: 44100.0,
			AVNumberOfChannelsKey: 1,
			AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
		]
		do {
			audioRecorder = try AVAudioRecorder(url: filePath, settings: recordSettings)
			audioRecorder?.delegate = self
		} catch {
			print("Error creating audioRecorder")
		}
	}
	
	public func startRecording() {
		audioRecorder?.record()
		status = .recording
	}
	
	public func pauseRecording() {
		
	}
	
	public func stopRecording() {
		audioRecorder?.stop()
		status = .stopped
	}
	
	public func playAudio(from filePath: URL) {
		do {
			audioPlayer = try AVAudioPlayer(contentsOf: filePath)
		} catch {
			print(error.localizedDescription)
		}
		guard let audioPlayer = audioPlayer else { return }
		audioPlayer.delegate = self
		if audioPlayer.duration > 0.0 {
			audioPlayer.play()
			status = .playing
		}
	}
	
	public func stopPlaying() {
		audioPlayer?.stop()
		status = .stopped
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
