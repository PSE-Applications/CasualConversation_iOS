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
			
			context("FactoryMethods - by FileManagerRepository") {
				
				it("call func makeAudioRecorder then AVAudioRecorder instance as AudioRecorderProtocol") {
					// Arrange
					var recorder: AVAudioRecorder?
					
					// Act
					recorder = recordRepository.makeAudioRecorder() as! AVAudioRecorder?
					
					// Assert
					expect(recorder).notTo(beNil())
					expect(recorder).to(beAKindOf(AVAudioRecorder.self))
				}
				
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
}
