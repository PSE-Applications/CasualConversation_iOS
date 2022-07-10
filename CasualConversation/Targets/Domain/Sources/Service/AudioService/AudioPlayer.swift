//
//  AudioPlayer.swift
//  Domain
//
//  Created by Yongwoo Marco on 2022/07/08.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common

import Foundation
import AVFoundation

struct AudioPlayer: Dependency {
	
	static func makePlayer(from filePath: URL) -> AudioPlayer? {
		guard let audioPlayer = try? AVAudioPlayer(contentsOf: filePath) else {
			return nil
		}
		return Self.init(dependency: .init(
			filePath: filePath,
			audioPlayer: audioPlayer))
	}
	
	struct Dependency {
		let filePath: URL
		var audioPlayer: AVAudioPlayer
	}
	
	let dependency: Dependency
	
	var currentTime: TimeInterval {
		dependency.audioPlayer.currentTime
	}

	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	func setupPlayer(delegate: AVAudioPlayerDelegate) {
		dependency.audioPlayer.delegate = delegate
	}
	
	func playback() {
		if dependency.audioPlayer.duration > 0.0 {
			dependency.audioPlayer.play()
		}
	}
	
	func pausePlaying() {
		dependency.audioPlayer.pause()
	}
	
	func stopPlaying() {
		dependency.audioPlayer.stop()
	}
	
}
