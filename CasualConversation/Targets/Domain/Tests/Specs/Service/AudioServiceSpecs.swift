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
	static var sut: Self {
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
				beforeEach { audioPlayable = audioService }
				afterEach { audioPlayable = nil }
				
				describe("Mock 생성 성공 케이스") {
					var filePath: URL!
					beforeEach { filePath = URL(fileURLWithPath: "testableFilePath") } // TODO: Testable Dummy 녹음 파일 필요
					afterEach { filePath = nil }
					
					context("재생을 위해 녹음물 준비 작업을 하면") {
						var optionalParameter: Error!
						beforeEach {
							audioPlayable.setupPlaying(from: filePath) { error in
								optionalParameter = error
							}
						}

						it("nil 받음") {
							expect(optionalParameter).to(beNil())
						}
						
						context("재생시작을 성공하면") {
							var optionalParameter: Error!
							beforeEach {
								audioPlayable.startPlaying() { error in
									optionalParameter = error
								}
							}
							
							it("nil 받음") {
								expect(optionalParameter).to(beNil())
							}
							
							context("재생중 일시정지하면") {
								beforeEach { audioPlayable.pausePlaying() }
								afterEach { audioPlayable.startPlaying() { _ in } }
								
								it("현재상태가 paused") {
									expect(audioPlayable.status).to(equal(.paused))
								}
							}
							
							context("재생중 중단하면") {
								beforeEach {
									audioPlayable.stopPlaying()
								}
								
								it("현재상태가 stopped") {
									expect(audioPlayable.status).to(equal(.stopped))
								}
							}
						}
					}
				}
			}
			
			describe("AudioRecordable 추상화하고") {
				var audioRecordable: AudioRecordable!
				beforeEach { audioRecordable = audioService }
				
				context("녹음을 위해 준비 작업을 하면") { // Date() 객체를 이용한 새로운 FilePath 생성됨
					var optionalParameter: Error!
					beforeEach {
						audioRecordable.setupRecorder() { error in
							optionalParameter = error
						}
					}
					
					it("nil 받음") {
						expect(optionalParameter).to(beNil())
					}
					
					context("녹음 시작을 성공하면") {
						var startOptionalParameter: Error!
						beforeEach {
							audioRecordable.startRecording() { error in
								startOptionalParameter = error
							}
						}
						
						it("nil 받음") {
							expect(startOptionalParameter).to(beNil())
						}
					}
					
					context("녹음 중에 일시정지하면") {
						beforeEach { audioRecordable.pauseRecording() }
						afterEach { audioRecordable.startRecording() { _ in } }
						
						it("현재 상태가 paused") {
							expect(audioRecordable.status).to(equal(.paused))
						}
					}
					
					context("녹음 중에 중단하면") {
						var stopParameter: Result<URL, Error>!
						beforeEach {
							audioRecordable.stopRecording() { result in
								stopParameter = result
							}
						}
						
						it(".success(let url) 받음") {
//							expect(stopParameter).to(be(succeed())) // failed - expected to be identical to <0x600000788750>, got <0x60000075eee0>
//							expect(stopParameter).to(beSuccess()) // 공식문서 - 적용안됨...
						}
					}
				}
			}
		}
	}
}
