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

import Foundation.NSURL

extension AudioPlayService {
	static var sut: Self {
		Self.init(dependency: .init(repository: MockRecordDataController()))
	}
}

final class AudioPlayServiceSpecs: QuickSpec {
	override func spec() {
		describe("인스턴스 객체") {
			var player: CCPlayer!
			beforeEach { player = AudioPlayService.sut }
			afterEach {	player = nil }
			
			describe("Mock 생성 성공 케이스") {
				var filePath: URL!
				beforeEach { filePath = URL(fileURLWithPath: "testableFilePath") } // TODO: Testable Dummy 녹음 파일 필요
				afterEach { filePath = nil }
				
				context("재생을 위해 녹음물 준비 작업을 하면") {
					var optionalParameter: CCError!
					beforeEach {
						player.setupPlaying(from: filePath) { error in
							optionalParameter = error
						}
					}
					
					it("nil 받음") {
						expect(optionalParameter).to(beNil())
					}
					
					context("재생시작을 성공하면") {
						var optionalParameter: CCError!
						beforeEach {
							player.startPlaying() { error in
								optionalParameter = error
							}
						}
						
						it("nil 받음") {
							expect(optionalParameter).to(beNil())
						}
						
						context("재생중 일시정지하면") {
							beforeEach { player.pausePlaying() }
							afterEach { player.startPlaying() { _ in } }
							
							it("현재상태가 paused") {
								expect(player.status).to(equal(.paused))
							}
						}
						
						context("재생중 중단하면") {
							beforeEach {
								player.stopPlaying()
							}
							
							it("현재상태가 stopped") {
								expect(player.status).to(equal(.stopped))
							}
						}
					}
				}
			}
		}
	}
}
