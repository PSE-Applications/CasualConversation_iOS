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
	func setupRecorder()
	func startRecording()
//	func pauseRecording()
	func stopRecording()
}

public final class RecordService: NSObject, Dependency, ObservableObject {
	
	@Published var status: AudioStatus = .stopped
	
	public var dependency: Dependency
	private var audioRecorder: AVAudioRecorder?
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

extension RecordService: RecordServiceProtocol {
	
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
	
}

extension RecordService: AVAudioRecorderDelegate {
	
	public func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		status = .stopped
	}
	
	
}
