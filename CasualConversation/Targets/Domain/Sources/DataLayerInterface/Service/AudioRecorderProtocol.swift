//
//  AudioRecorderProtocol.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/11.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Foundation.NSURL
import AVFAudio.AVAudioPlayer

public protocol AudioRecorderProtocol {
	var delegate: AVAudioRecorderDelegate? { get set }
	var url: URL { get }
	var isRecording: Bool { get }
	var currentTime: TimeInterval { get }
	func prepareToRecord() -> Bool
	func record() -> Bool
	func pause()
	func stop()
}
