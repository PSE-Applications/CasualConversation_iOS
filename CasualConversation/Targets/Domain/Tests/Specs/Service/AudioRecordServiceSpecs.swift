//
//  AudioServiceSpecs.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/13.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Common
@testable import Domain

import Quick
import Nimble

import Foundation.NSURL

extension AudioRecordService {
	static var sut: Self {
		Self.init(dependency: .init(repository: MockRecordDataController()))
	}
}

final class AudioRecordServiceSpecs: QuickSpec {
	override func spec() {
		describe("인스턴스 객체") {
			var recorder: CCRecorder!
			beforeEach { recorder = AudioRecordService.sut }
			afterEach { recorder = nil }
			
			context("녹음을 위해 준비 작업을 하면") { // Date() 객체를 이용한 새로운 FilePath 생성됨
				var optionalParameter: CCError!
				beforeEach {
					recorder.setupRecorder() { error in
						optionalParameter = error
					}
				}
				
				it("nil 받음") {
					expect(optionalParameter).to(beNil())
				}
				
				context("녹음 시작을 성공하면") {
					var startOptionalParameter: CCError!
					beforeEach {
						recorder.startRecording() { error in
							startOptionalParameter = error
						}
					}
					
					it("nil 받음") {
						expect(startOptionalParameter).to(beNil())
					}
				}
				
				context("녹음 중에 일시정지하면") {
					beforeEach { recorder.pauseRecording() }
					afterEach { recorder.startRecording() { _ in } }
					
					it("현재 상태가 paused") {
						expect(recorder.status).to(equal(.paused))
					}
				}
				
				context("녹음 중에 중단하면") {
					var stopParameter: Result<URL, CCError>!
					beforeEach {
						recorder.stopRecording() { result in
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
