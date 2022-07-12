//
//  AudioPlayerProtocol.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/11.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Foundation
import AVFAudio

public protocol AudioPlayerProtocol {
	var isPlaying: Bool { get }
	var currentTime: TimeInterval { get }
	var duration: TimeInterval { get }
	var delegate: AVAudioPlayerDelegate? { get set }
	func prepareToPlay() -> Bool
	func play() -> Bool
	func pause()
	func stop()
}
