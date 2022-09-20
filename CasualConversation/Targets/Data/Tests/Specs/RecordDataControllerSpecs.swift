//
//  RecordDataControllerSpecs.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/18.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Data

import Quick
import Nimble

import AVFAudio

extension RecordDataController {
	fileprivate static var sut: Self {
		Self.init(dependency: .init(repository: FileManagerRepository()))
	}
}

final class RecordDataControllerSpecs: QuickSpec {
	override func spec() {
		describe("인스턴스 객체") {
			var recordRepository: RecordDataController!
			beforeEach { recordRepository = .sut }
			afterEach { recordRepository = nil }
			
			describe("새로운 녹음물 저장할 filePath 가진 객체 생성을 위해서") {
				context("makeAudioRecorder 팩토리메서드 호출하면") {
					var recorder: AVAudioRecorder?
					beforeEach { recorder = recordRepository.makeAudioRecorder() as? AVAudioRecorder }
					
					it("추상화된 AVAudioRecorder 객체 생성됨") {
						expect(recorder).notTo(beNil())
						expect(recorder).to(beAnInstanceOf(AVAudioRecorder.self))
					}
				}
			}
			
			describe("filePath의 녹음물 가진 객체 생성을 위해서") {
				describe("잘못된 filePath를 전달하는") {
					var wrongFilePath: URL!
					beforeEach { wrongFilePath = URL(fileURLWithPath: "failurePath") }
					
					context("makeAudioPlayer 팩토리메서드 호출하면") {
						var player: AVAudioPlayer?
						beforeEach { player = recordRepository.makeAudioPlayer(from: wrongFilePath) as? AVAudioPlayer }
						
						it("추상화된 AVAudioPlayer 객체 생성되지 않음") {
							expect(player).to(beNil())
						}
					}
				}
			
				// TODO: - Dummy 테스트 녹음 파일 필요함 (테스트 용 Bundle?) - 성공케이스
//				describe("올바른 filePath를 전달하는") {
//					var correctFilePath: URL!
//					beforeEach { correctFilePath = URL(fileURLWithPath: "") }
//
//					context("팩토리메서드 호출하면") {
//						var player: AVAudioPlayer?
//						beforeEach { player = recordRepository.makeAudioPlayer(from: correctFilePath) as? AVAudioPlayer }
//
//						it("추상화된 AVAudioPlayer 객체 생성됨") {
//							expect(player).notTo(beNil())
//							expect(player).to(beAnInstanceOf(AVAudioPlayer.self))
//						}
//					}
//				}
			}
		}
	}
}

