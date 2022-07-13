//
//  AudioRecorderProtocol.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/11.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Foundation
import AVFAudio

public protocol AudioRecorderProtocol where Self: AVAudioRecorder {
	var delegate: AVAudioRecorderDelegate? { get set }
	var url: URL { get }
	var isRecording: Bool { get }
	var currentTime: TimeInterval { get }
	func prepareToRecord() -> Bool
	func record() -> Bool
	func pause()
	func stop()
}
