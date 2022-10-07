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

import Foundation
import Combine

extension AudioRecordService {
	static var sut: Self {
		Self.init(dependency: .init(dataController: MockRecordDataController()))
	}
}

final class AudioRecordServiceSpecs: QuickSpec {
	override func spec() {
		describe("인스턴스 객체") {
			var recorder: CCRecorder!
			var cancellableSet: Set<AnyCancellable>!
			beforeEach {
				recorder = AudioRecordService.sut
				cancellableSet = []
			}
			afterEach {
				recorder = nil
				cancellableSet = nil
			}
			
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
					var result: Bool!
					beforeEach {
						recorder.startRecording()
						recorder.isRecordingPublisher
							.sink { event in
								result = event
							}
							.store(in: &cancellableSet)
					}
					afterEach { result = nil }
					
					it("isRecording true 받음") {
						expect(result).to(be(true))
					}
				}
				
				context("녹음 중에 일시정지하면") {
					var result: Bool!
					beforeEach {
						recorder.startRecording()
						recorder.pauseRecording()
						recorder.isRecordingPublisher
							.sink { event in
								result = event
							}
							.store(in: &cancellableSet)
					}
					afterEach { result = nil }
					
					it("isRecording false 받음") {
						expect(result).to(equal(false))
					}
				}
				
				context("녹음 중에 중단하면") {
					var result: URL!
					beforeEach {
						recorder.startRecording()
						recorder.stopRecording { parameter in
							switch parameter {
							case .success(let url):
								result = url
							case .failure(_):
								break
							}
						}
					}
					afterEach { result = nil }
					
					it("isPlaying false 받음") {
						expect(result).notTo(beNil())
					}
				}
			}
		}
	}
}
