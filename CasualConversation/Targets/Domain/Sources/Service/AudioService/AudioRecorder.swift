//
//  AudioRecorder.swift
//  Domain
//
//  Created by Yongwoo Marco on 2022/07/08.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common

import Foundation
import AVFoundation

struct AudioRecorder: Dependency {
	
	static func makeRecorder(from filePath: URL) -> AudioRecorder? {
		let recordSettings: [String: Any] = [
			AVFormatIDKey: Int(kAudioFormatLinearPCM),
			AVSampleRateKey: 44100.0,
			AVNumberOfChannelsKey: 1,
			AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
		]
		guard let audioRecorder = try? AVAudioRecorder(url: filePath, settings: recordSettings) else {
			return nil
		}
		return Self.init(dependency: .init(
			filePath: filePath,
			audioRecorder: audioRecorder))
	}
	
	struct Dependency {
		let filePath: URL
		var audioRecorder: AVAudioRecorder
	}
	
	let dependency: Dependency
	
	var currentTime: TimeInterval {
		dependency.audioRecorder.currentTime
	}

	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	func setupRecorder(delegate: AVAudioRecorderDelegate) {
		dependency.audioRecorder.delegate = delegate
	}
	
	func startRecording() {
		dependency.audioRecorder.record()
	}
	
	func pauseRecording() {
		dependency.audioRecorder.pause()
	}
	
	func stopRecording() -> URL {
		dependency.audioRecorder.stop()
		let filePath = dependency.audioRecorder.url
		return filePath
	}
	
}
