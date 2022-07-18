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

import Foundation.NSURL

extension AudioService {
	fileprivate static var sut: Self {
		Self.init(dependency: .init(repository: MockRecordRepository()))
	}
}

final class AudioServiceSpecs: QuickSpec {
	override func spec() {
		describe("인스턴스 객체") {
			var audioService: AudioServiceProtocol!
			beforeEach { audioService = AudioService.sut }
			afterEach { audioService = nil }
			
			describe("AudioPlayable 추상화하고") {
				var audioPlayable: AudioPlayable!
				var filePath: URL!
				beforeEach {
					audioPlayable = audioService
					filePath = URL(fileURLWithPath: "testableFilePath")
				}
				afterEach {
					audioPlayable = nil
					filePath = nil
				}
				
				context("재생을 위해 녹음물 filePath로 준비 작업을 하면") {
					beforeEach { _ = audioPlayable.setupPlaying(from: filePath) }
					
					it("현재재생시간을 확인가능함") {
						expect(audioPlayable.currentPlayingTime).to(equal(TimeInterval(0.0)))
					}
				}
				
				context("재생을 시작하면") {
					beforeEach {
						_ = audioPlayable.setupPlaying(from: filePath)
						_ = audioPlayable.startPlaying()
					}
					
					it("현재상태가 재생중") {
						expect(audioPlayable.status).to(equal(.playing))
					}
				}
				
				context("재생중 일시정지하면") {
					beforeEach {
						_ = audioPlayable.startPlaying()
						audioPlayable.pausePlaying()
					}
					
					it("현재상태가 일시정지중") {
						expect(audioPlayable.status).to(equal(.paused))
					}
				}
				
				context("재생중 중단하면") {
					beforeEach {
						_ = audioPlayable.startPlaying()
						audioPlayable.stopPlaying()
					}
					
					it("현재상태가 중단중") {
						expect(audioPlayable.status).to(equal(.stopped))
					}
				}
			}
			
			describe("AudioRecordable 추상화하고") {
				var audioRecordable: AudioRecordable!
				beforeEach { audioRecordable = audioService }
				
				context("녹음을 위해 준비 작업을 하면") {
					beforeEach { _ = audioRecordable.setupRecorder() }
					
					it("현재녹음시간을 확인가능함") {
						expect(audioRecordable.currentRecordingTime).to(equal(TimeInterval(0.0)))
					}
				}
				
				context("녹음을 시작하면") {
					beforeEach {
						_ = audioRecordable.setupRecorder()
						_ = audioRecordable.startRecording()
					}
					
					it("현재 상태가 녹음중") {
						expect(audioService.status).to(equal(.recording))
					}
				}
				
				context("녹음 중에 일시정지하면") {
					beforeEach {
						_ = audioRecordable.startRecording()
						_ = audioRecordable.pauseRecording()
					}
					
					it("현재 상태가 일시정지중") {
						expect(audioRecordable.status).to(equal(.paused))
					}
				}
				
				context("녹음 중에 중단하면") {
					beforeEach {
						_ = audioRecordable.startRecording()
						_ = audioRecordable.stopRecording()
					}
					
					it("현재 상태가 중단중") {
						expect(audioRecordable.status).to(equal(.stopped))
					}
				}
			}
		}
	}
}
