//
//  RecordDataControllerProtocol.swift
//  Domain
//
//  Created by Yongwoo Marco on 2022/07/04.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Foundation.NSURL

public protocol RecordDataControllerProtocol {
	func makeAudioRecorder() -> AudioRecorderProtocol?
	func makeAudioPlayer(from filePath: URL) -> AudioPlayerProtocol?
}
