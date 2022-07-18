//
//  MockRecordRepository.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/13.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Domain

import Foundation
import AVFAudio

struct MockRecordRepository {
	
	private var directory = FileManager.default.temporaryDirectory
	
}

extension MockRecordRepository: RecordRepositoryProtocol {
	
	public func makeAudioRecorder() -> AudioRecorderProtocol? {
		return MockAudioRecorder(delegate: nil, url: URL(string: "fake")!)
	}
	
	public func makeAudioPlayer(from filePath: URL) -> AudioPlayerProtocol? {
		return MockAudioPlayer(delegate: nil, url: filePath)
	}
	
}
