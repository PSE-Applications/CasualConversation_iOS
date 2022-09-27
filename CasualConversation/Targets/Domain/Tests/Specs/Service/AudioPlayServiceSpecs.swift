//
//  AudioPlayServiceSpecs.swift
//  Domain
//
//  Created by Yongwoo Marco on 2022/08/17.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Common
@testable import Domain

import Quick
import Nimble

import Foundation
import Combine

extension AudioPlayService {
	static var sut: Self {
		Self.init(dependency: .init(dataController: MockRecordDataController()))
	}
}

final class AudioPlayServiceSpecs: QuickSpec {
	override func spec() {
		describe("인스턴스 객체") {
			var player: CCPlayer!
			var cancellableSet: Set<AnyCancellable>!
			beforeEach {
				player = AudioPlayService.sut
				cancellableSet = []
			}
			afterEach {
				player = nil
				cancellableSet = nil
			}
			
			describe("Invalidated FilePath 가진 Mock 생성") {
				var filePath: URL!
				beforeEach { filePath = URL(fileURLWithPath: "testableFilePath") } // TODO: Testable Dummy 녹음 파일 필요
				afterEach { filePath = nil }
				
				context("재생을 위해 녹음물 준비 작업을 하면") {
					var optionalParameter: CCError!
					beforeEach {
						player.setupPlaying(filePath: filePath) { error in
							optionalParameter = error
						}
					}
					afterEach { optionalParameter = nil }
					
					it("테스트용 URL이라 실패해서 error를 가짐") {
						expect(optionalParameter).notTo(beNil())
					}
					
					context("재생시작을 성공하면") {
						var result: Bool!
						beforeEach {
							player.startPlaying()
							player.isPlayingPublisher
								.sink { event in
									result = event
								}
								.store(in: &cancellableSet)
						}
						afterEach { result = nil }
						
						it("isPlaying true 받음") {
							expect(result).to(be(true))
						}
						
						context("재생 중에 일시정지하면") {
							var result: Bool!
							beforeEach {
								player.startPlaying()
								player.pausePlaying()
								player.isPlayingPublisher
									.sink { event in
										result = event
									}
									.store(in: &cancellableSet)
							}
							afterEach { result = nil }
							
							it("isPlaying false 받음") {
								expect(result).to(equal(false))
							}
						}
						
						context("재생 중에 중단하면") {
							var result: Bool!
							beforeEach {
								player.startPlaying()
								player.pausePlaying()
								player.isPlayingPublisher
									.sink { event in
										result = event
									}
									.store(in: &cancellableSet)
							}
							afterEach { result = nil }
							
							it("isPlaying false 받음") {
								expect(result).to(equal(false))
							}
						}
					}
				}
			}
		}
	}
}
