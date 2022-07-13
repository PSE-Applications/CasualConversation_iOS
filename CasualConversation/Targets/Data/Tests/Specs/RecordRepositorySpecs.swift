//
//  RecordRepositorySpecs.swift
//  DataTests
//
//  Created by Yongwoo Marco on 2022/07/12.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Data

import Quick
import Nimble

import Foundation
import AVFAudio

final class RecordRepositorySpecs: QuickSpec {
	
	override func spec() {
		
		var fileManagerRepository: FileManagerRepository!
		var recordRepository: RecordRepository!
		
		describe("as RecordRepository") {
		
			beforeSuite {
				fileManagerRepository = FileManagerRepository()
				recordRepository = RecordRepository(dependency: .init(
					repository: fileManagerRepository
				)
				)
			}
			
			afterSuite {
				fileManagerRepository = nil
				recordRepository = nil
			}
			
			
			context("FactoryMethods") {
				
				it("call func makeAudioRecorder then AVAudioRecorder instance as AudioRecorderProtocol") {
					// Arrange
					var recorder: AVAudioRecorder
					
					// Act
					recorder = recordRepository.makeAudioRecorder()!
					
					// Assert
					expect(recorder).notTo(beNil())
					expect(recorder).to(beAKindOf(AVAudioRecorder.self))
				}
			}
			
			// TODO: 임시 파일이 필요함 실제로 읽을 수 있는 filePath 필요
//			it("call makeAudioPlayer(_:) then AVAudioPlayer as AudioPlayerProtocol") {
//				// Arrange
//				let filePath = URL(fileURLWithPath: "newFilePath")
//				var player: AVAudioPlayer?
//
//				// Act
//				player = recordRepository.makeAudioPlayer(from: filePath) as? AVaudioPlayer
//
//
//				// Assert
//				expect(player).notTo(beNil())
//				expect(player).to(beAKindOf(AVAudioPlayer.self))
//			}
			
			it("call func makeAudioPlayer by incorrect filePath then nil") {
				// Arrange
				let filePath = URL(fileURLWithPath: "failurePath")
				var player: AVAudioPlayer?
				
				// Act
				player = recordRepository.makeAudioPlayer(from: filePath) as? AVAudioPlayer
				
				// Assert
				expect(player).to(beNil())
			}
		}
	}
}
