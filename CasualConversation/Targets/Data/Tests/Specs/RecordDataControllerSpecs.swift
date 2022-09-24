//
//  RecordDataControllerSpecs.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/18.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Data

import Foundation

import Quick
import Nimble

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
			
			describe("새로운 녹음물 저장 위해서") {
				context("requestNewFilePath 메서드 호출하면") {
					var result: URL!
					beforeEach { result = recordRepository.requestNewFilePath() }
					afterEach { result = nil }
					
					it("URL 생성됨") {
						expect(result).notTo(beNil())
						expect(result).to(beAnInstanceOf(URL.self))
					}
				}
			}
			
			describe("잘못된 filePath를 이용해서") {
				var invalidatedFilePath: URL!
				beforeEach { invalidatedFilePath = URL(fileURLWithPath: "Error") }
				afterEach { invalidatedFilePath = nil }
				
				context("녹음 파일 불러오기 요청하면") {
					var result: Data!
					beforeEach { result = recordRepository.requestRecordData(from: invalidatedFilePath) }
					afterEach { result = nil }
					
					it("불러오기 실패해서 반환값 없음") {
						expect(result).to(beNil())
					}
				}
				
				context("녹음 파일 삭제 요청하면") {
					var result: Any!
					beforeEach {
						recordRepository.deleteRecordData(from: invalidatedFilePath) { error in
								result = error
							}
					}
					afterEach { result = nil }
					
					it("에러 값을 매개변수로 completion 동작") {
						expect(result).notTo(beNil())
					}
				}
			}
		}
	}
}

