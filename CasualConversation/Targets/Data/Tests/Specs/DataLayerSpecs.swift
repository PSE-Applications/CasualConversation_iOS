//
//  DataLayerSpecs.swift
//  DataTests
//
//  Created by Yongwoo Marco on 2022/07/12.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Data
@testable import Domain

import Quick
import Nimble

import AVFAudio

final class DataLayerSpecs: QuickSpec {
	override func spec() {
		
		var fileManagerRepository: FileManagerRepository!
		
		beforeSuite { fileManagerRepository = FileManagerRepository() }
		afterSuite { fileManagerRepository = nil }
		
		// MARK: - ConversationRepository Specs
		
		// MARK: - NoteRepository Specs
	
		// MARK: - RecordRepository Specs
		describe("RecordRepository 객체") {
			var recordRepository: RecordRepository!
			
			beforeEach {
				recordRepository = RecordRepository(dependency: .init(
						repository: fileManagerRepository
					)
				)
			}
			afterEach { recordRepository = nil }
			
			describe("녹음을 하기 위해서 새로운 녹음물 저장할 filePath를 가진 객체 생성을 위해서") {
				context("팩토리메서드 호출하면") {
					var recorder: AudioRecorderProtocol?
					
					beforeEach {
						recorder = recordRepository.makeAudioRecorder()
					}
					
					it("추상화된 AVAudioRecorder 객체 생성됨") {
						expect(recorder).notTo(beNil())
						expect(recorder).to(beAnInstanceOf(AVAudioRecorder.self))
						expect(recorder).to(beAKindOf(AudioRecorderProtocol.self))
					}
				}
			}
			
			describe("저장된 filePath의 녹음물 가진 객체 생성을 위해서") {
				context("잘못된 filePath를 전달하는 팩토리메서드 호출하면") {
					let filePath = URL(fileURLWithPath: "failurePath")
					var player: AudioPlayerProtocol?
					
					beforeEach {
						player = recordRepository.makeAudioPlayer(from: filePath)
					}
					
					it("추상화된 AVAudioPlayer 객체 생성되지 않음") {
						expect(player).to(beNil())
					}
				}
				
				// TODO: - Dummy 테스트 녹음 파일 필요함 (테스트 용 Bundle?) - 성공케이스
//				context("올바른 filePath를 전달하는 팩토리메서드 호출하면") {
//					let filePath = URL(fileURLWithPath: "")
//					var player: AudioPlayerProtocol?
//
//					beforeEach {
//						player = recordRepository.makeAudioPlayer(from: filePath)
//					}
//
//					it("추상화된 AVAudioPlayer 객체 생성됨") {
//						expect(player).notTo(beNil())
//						expect(player).to(beAnInstanceOf(AVAudioPlayer.self))
//						expect(player).to(beAKindOf(AudioPlayerProtocol.self))
//					}
//				}
			}
		}
	}
}
