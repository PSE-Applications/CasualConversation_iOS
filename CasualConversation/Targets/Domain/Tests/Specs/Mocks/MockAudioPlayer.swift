//
//  MockAudioPlayer.swift
//  DomainTests
//
//  Created by Yongwoo Marco on 2022/07/14.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Domain

import Foundation
import AVFAudio

final class MockAudioPlayer: AudioPlayerProtocol {
	var delegate: AVAudioPlayerDelegate?
	var url: URL?
	var isPlaying: Bool = false
	
	init(delegate: AVAudioPlayerDelegate?, url: URL?) {
		self.delegate = delegate
		self.url = url
	}
	
	var currentTime: TimeInterval {
		0.0
	}
	var duration: TimeInterval {
		10.0
	}
	
	func prepareToPlay() -> Bool {
		isPlaying = false
		return true
	}
	
	func play() -> Bool {
		isPlaying = true
		return true
	}
	
	func pause() {
		isPlaying = false
	}
	
	func stop() {
		isPlaying = false
	}
	
}
