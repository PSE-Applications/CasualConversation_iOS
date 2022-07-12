//
//  RecorderRepositorySpecs.swift
//  DataTests
//
//  Created by Yongwoo Marco on 2022/07/12.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Data

final class RecorderRepositorySpecs: QuickSpec {
	
	var repository: RecordRepository
	
	beforeEach {
		repository = RecordRepository()
	}
	
	override func spec() {
		description("Factory Methods") {
			let nowDate = Date()
			
			context("call makeAudioRecorder()") {
				let prefixOffset = 10 // 2022.00.00
				let nowDateStringPrefix = nowDate.formatted(.dateTime).prefix(prefixOffset)
				
				it("return AVAudioRecorder as AudioRecorderProtocol") {
					let recorder = repository.makeAudioRecorder()
					
					expect(recorder?.url.description.prefix(prefixOffset))
						.to(equal(nowDate.formatted(.dateTime).prefix(prefixOffset)))
				}
			}
			
			context("call makeAudioPlayer(_:)") {
				let filePath = URL(fileURLWithPath: "newFilePath")
				
				it("return AVAudioPlayer as AudioPlayerProtocol") {
					let player = repository.makeAudioPlayer(from: filePath)
					
					expect(player?.url!)
						.to(filePath)
				}
			}
		}
	}
	
}
