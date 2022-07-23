//
//  AudioPlayerProtocol.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/11.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Foundation.NSURL
import AVFAudio.AVAudioPlayer

public protocol AudioPlayerProtocol {
	var delegate: AVAudioPlayerDelegate? { get set }
	var url: URL? { get }
	var isPlaying: Bool { get }
	var currentTime: TimeInterval { get }
	var duration: TimeInterval { get }
	func prepareToPlay() -> Bool
	func play() -> Bool
	func pause()
	func stop()
}
