//
//  RecordRepository.swift
//  Domain
//
//  Created by Yongwoo Marco on 2022/07/04.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

import Foundation
import AVFAudio

extension AVAudioRecorder: AudioRecorderProtocol { }
extension AVAudioPlayer: AudioPlayerProtocol { }

public struct RecordRepository: Dependency {
	
	public var dependency: Dependency
	
	public struct Dependency {
		public let repository: FileManagerRepositoryProtocol
		
		public init(repository: FileManagerRepositoryProtocol) {
			self.repository = repository
		}
	}
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}
	
}

extension RecordRepository: RecordRepositoryProtocol {
	
	public func makeAudioRecorder() -> AudioRecorderProtocol? {
		let recordSettings: [String: Any] = [
			AVFormatIDKey: Int(kAudioFormatLinearPCM),
			AVSampleRateKey: 44100.0,
			AVNumberOfChannelsKey: 1,
			AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
		]
		let currentDate = Date().formatted(.dateTime)
		let newFilePath = dependency.repository.directoryPath.appendingPathComponent(currentDate.description)
		let recorder = try? AVAudioRecorder(url: newFilePath, settings: recordSettings)
		return recorder
	}
	
	public func makeAudioPlayer(from filePath: URL) -> AudioPlayerProtocol? {
		guard let player = try? AVAudioPlayer(contentsOf: filePath) else {
			return nil
		}
		return player
	}
	
}
