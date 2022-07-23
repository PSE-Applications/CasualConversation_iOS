//
//  MockAudioRecorder.swift
//  DomainTests
//
//  Created by Yongwoo Marco on 2022/07/14.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Domain

import Foundation
import AVFAudio

final class MockAudioRecorder: AudioRecorderProtocol {
	var delegate: AVAudioRecorderDelegate?
	var url: URL
	var isRecording: Bool = false
	
	init(delegate: AVAudioPlayerDelegate?, url: URL) {
		self.delegate = delegate as? AVAudioRecorderDelegate
		self.url = url
	}
	
	var currentTime: TimeInterval {
		0.0
	}
	
	func prepareToRecord() -> Bool {
		isRecording = false
		return true
	}
	
	func record() -> Bool {
		isRecording = true
		return true
	}
	
	func pause() {
		isRecording = false
	}
	
	func stop() {
		isRecording = false
	}
	
}

