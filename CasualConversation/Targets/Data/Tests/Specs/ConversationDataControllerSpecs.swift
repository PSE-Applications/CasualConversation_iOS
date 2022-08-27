//
//  ConversationDataControllerSpecs.swift
//  Data
//
//  Created by Yongwoo Marco on 2022/07/29.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Data
@testable import Common
@testable import Domain

import Quick
import Nimble

extension ConversationDataController {
	fileprivate static var sut: Self {
		Self.init(dependency: .init(coreDataStack: TestCoreDataStack())
		)
	}
}

final class ConversationDataControllerSpecs: QuickSpec {
	override func spec() {
		describe("인스턴스 객체가") {
			var conversationRepository: ConversationDataControllerProtocol!
			beforeEach { conversationRepository = ConversationDataController.sut }
			afterEach { conversationRepository = nil }
			
			describe("새 데이터를") {
				var newItem: Conversation!
				beforeEach { newItem = .empty }
				afterEach { newItem = nil }
				
				context("create 메서드로 추가하면") {
					var parameter: CCError?
					beforeEach {
						conversationRepository.create(newItem) { error in
							parameter = error
						}
					}
					afterEach { parameter = nil	}
					
					it("completion 매개변수 nil 받음") {
						expect(parameter).to(beNil())
					}
				}
				
				context("추가 후 fetchRequest 메서드로 데이터 불러오기 시도하면") {
					var list: [Conversation]?
					beforeEach {
						conversationRepository.create(newItem, completion: { _ in })
						list = conversationRepository.fetch()
					}
					afterEach { list = nil }
					
					it("반환값 1개 존재함") {
						expect(list).notTo(beNil())
						expect(list?.count).to(be(1))
					}
				}
				
				context("추가 후 delete 메서드로 제거하고 데이터 불러오기 시도하면") {
					var list: [Conversation]?
					var parameter: CCError?
					beforeEach {
						conversationRepository.create(newItem, completion: { _ in })
						conversationRepository.delete(newItem) { error in
							parameter = error
						}
						list = conversationRepository.fetch()
					}
					afterEach { list = nil }
					
					it("completion 매개변수 nil 받고, 반환값 0개 존재") {
						expect(parameter).to(beNil())
						expect(list).notTo(beNil())
						expect(list?.count).to(be(0))
					}
				}
				
				context("추가 후 update 메서드로 변경하면 하고 데이터 불러오기 시도하면") {
					var list: [Conversation]?
					var parameter: CCError?
					beforeEach {
						conversationRepository.create(newItem, completion: { _ in })
						conversationRepository.update(after: .init(
							id: newItem.id,
							title: "newTitle",
							topic: newItem.topic,
							members: newItem.members,
							recordFilePath: newItem.recordFilePath,
							recordedDate: newItem.recordedDate,
							pins: newItem.pins
						)) { error in
							parameter = error
						}
						list = conversationRepository.fetch()
					}
					afterEach { list = nil }
					
					it("completion 매개변수 nil 받고, 기존값과 다름") {
						expect(parameter).to(beNil())
						expect(list).notTo(beNil())
						expect(list?.count).to(be(1))
						expect(list?.first!.title).notTo(be(newItem.title))
					}
				}
			}
		}
	}
}

