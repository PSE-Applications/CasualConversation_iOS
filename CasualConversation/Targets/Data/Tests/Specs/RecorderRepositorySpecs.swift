//
//  RecorderRepositorySpecs.swift
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

final class RecorderRepositorySpecs: QuickSpec {
	
	override func spec() {
		
		var fileManagerRepository: FileManagerRepository!
		var recordRepository: RecordRepository!
		
		beforeEach {
			fileManagerRepository = FileManagerRepository()
			recordRepository = RecordRepository(dependency: .init(repository: fileManagerRepository))
		}
		
		describe("Factory Methods") {
			
			context("call makeAudioRecorder()") {
				it("return AVAudioRecorder instance as AudioRecorderProtocol") {
					let recorder = recordRepository.makeAudioRecorder()
					
					expect(recorder).notTo(beNil())
					expect(recorder).to(beAKindOf(AVAudioRecorder.self))
				}
			}
			
			// 임시 파일이 필요함
//			context("call makeAudioPlayer(_:)") {
//				let filePath = URL(fileURLWithPath: "newFilePath")
//
//				it("return AVAudioPlayer as AudioPlayerProtocol") {
//					let player = recordRepository.makeAudioPlayer(from: filePath)
//
//					expect(player).notTo(beNil())
//					expect(player).to(beAKindOf(AVAudioPlayer.self))
//				}
//			}
			
			context("call makeAudioPlayer(_:) by incorrect filePath") {
				let filePath = URL(fileURLWithPath: "failurePath")
				
				it("return nil") {
					let player = recordRepository.makeAudioPlayer(from: filePath)
					
					expect(player).to(beNil())
				}
			}
		}
	}
	
}
