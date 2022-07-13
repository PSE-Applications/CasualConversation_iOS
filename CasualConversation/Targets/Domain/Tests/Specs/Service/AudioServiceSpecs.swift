//
//  AudioServiceSpecs.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/13.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Domain

import Quick
import Nimble

import Foundation

final class AudioServiceSpecs: QuickSpec {
	
	override func spec() {
		
		var recordRepository: RecordRepositoryProtocol!
		var audioService: AudioServiceProtocol!
		
		describe("as AudioServiceProtocol") {
			
			beforeSuite {
				recordRepository = MockRecordRepository()
				audioService = AudioService(dependency: .init(
						repository: recordRepository
					)
				)
			}
			
			afterSuite {
				recordRepository = nil
				audioService = nil
			}
			
			context("Adopted AudioPlayable") {
				var audioPlayable: AudioPlayable!
				
				beforeEach {
					audioPlayable = audioService
				}
				
				afterEach {
					audioPlayable = nil
				}
				
				it("call setupRecorder then currentPlayingTime eqaul 0.0") {
					// Arrange
					let filePath = URL(fileURLWithPath: "")
					
					// Act
					_ = audioPlayable.setupPlaying(from: filePath)
					
					// Assert
					expect(audioPlayable.currentPlayingTime).to(equal(TimeInterval(0.0)))
				}
				
				it("call func startPlaying then status eqaul .playing") {
					// Arrange
					
					// Act
					_ = audioPlayable.startPlaying()
					
					// Assert
					expect(audioPlayable.status).to(equal(.playing))
				}
				
				it("call func setupRecorder then currentPlayingTime eqaul 0.0") {
					// Arrange
					let filePath = URL(fileURLWithPath: "")
					
					// Act
					_ = audioPlayable.setupPlaying(from: filePath)
					
					// Assert
					expect(audioPlayable.currentPlayingTime).to(equal(TimeInterval(0.0)))
				}
				
				it("call func pausePlaying then status eqaul .paused") {
					// Arrange
					_ = audioPlayable.startPlaying()
					
					// Act
					audioPlayable.pausePlaying()
					
					// Assert
					expect(audioPlayable.status).to(equal(.paused))
				}
				
				it("call func stopPlaying then status eqaul .stopped") {
					// Arrange
					_ = audioPlayable.startPlaying()
					
					// Act
					audioPlayable.stopPlaying()
					
					// Assert
					expect(audioPlayable.status).to(equal(.stopped))
				}
			}
			
			context("Adopted AudioRecordable") {
				var audioRecordable: AudioRecordable!
				
				beforeEach {
					audioRecordable = audioService
				}
				
				afterEach {
					audioRecordable = nil
				}
				
				it("func call setupRecorder then currentRecordingTime eqaul 0.0") {
					// Arrange
					
					// Act
					_ = audioRecordable.setupRecorder()
					
					// Assert
					expect(audioRecordable.currentRecordingTime).to(equal(TimeInterval(0.0)))
				}
				
				it("func call startRecording then status eqaul .recording") {
					// Arrange
					
					// Act
					_ = audioRecordable.startRecording()
					
					// Assert
					expect(audioService.status).to(equal(.recording))
				}
				
				it("func call pauseRecording then status eqaul .paused") {
					// Arrange
					_ = audioRecordable.startRecording()
					
					// Act
					_ = audioRecordable.pauseRecording()
					
					// Assert
					expect(audioRecordable.status).to(equal(.paused))
				}
				
				it("func call stopRecording then status eqaul .stopped") {
					// Arrange
					_ = audioRecordable.startRecording()
					
					// Act
					_ = audioRecordable.stopRecording()
					
					// Assert
					expect(audioRecordable.status).to(equal(.stopped))
				}
			}
		}
	}
}
