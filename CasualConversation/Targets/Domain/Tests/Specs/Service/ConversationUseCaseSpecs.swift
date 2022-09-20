//
//  ConversationUseCaseSpecs.swift
//  DomainTests
//
//  Created by Yongwoo Marco on 2022/07/20.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Common
@testable import Domain

import Quick
import Nimble

extension ConversationUseCase {
	fileprivate static func sut(case type: Bool, error: CCError? = nil) -> ConversationUseCase {
		.init(dependency: .init(
			repository: MockConversationDataController(case: type, error: error))
		)
	}
}

final class ConversationUseCaseSpecs: QuickSpec {
	override func spec() {
		describe("인스턴스 객체가") {
			var conversationUseCase: ConversationUseCase!
			
			describe("성공케이스 할당해서") {
				beforeEach { conversationUseCase = .sut(case: true) }
				afterEach { conversationUseCase = nil }
				
				describe("ConversationManagable 추상화하고") {
					var managable: ConversationManagable!
					beforeEach { managable = conversationUseCase }
					afterEach { managable = conversationUseCase	}
					
					context("add 메서드 호출하면") {
						var parameter: CCError!
						beforeEach { managable.add(.empty) { error in
								parameter = error
							}
						}
						
						it("completion 매개변수 nil 받음") {
							expect(parameter).to(beNil())
						}
					}
				}
				
				describe("ConversationMaintainable 추상화하고") {
					var maintainable: ConversationMaintainable!
					beforeEach { maintainable = conversationUseCase }
					afterEach { maintainable = nil }
					
					describe("Conversation 유지보수") {
						let baseItem = Conversation.empty
						
						context("수정하면") {
							var parameter: CCError!
							beforeEach {
								maintainable.edit(after:
										.init(
											id: baseItem.id,
											title: "변경 제목",
											topic: "변경 주제",
											members: baseItem.members,
											recordFilePath: baseItem.recordFilePath,
											recordedDate: baseItem.recordedDate,
											pins: baseItem.pins
										)
								) { error in
									parameter = error
								}
							}
							
							it("completion 매개변수 nil 받음") {
								expect(parameter).to(beNil())
							}
						}
						
						context("삭제하면") {
							var parameter: CCError!
							beforeEach {
								maintainable.delete(baseItem) { error in
									parameter = error
								}
							}
							
							it("completion 매개변수 nil 받음") {
								expect(parameter).to(beNil())
							}
						}
					}
				}
			}
			describe("실패케이스 - bindingFailure") {
				beforeEach {
					conversationUseCase = .sut(
						case: false,
						error: .audioServiceFailed(reason: .bindingFailure)
					)
				}
				afterEach { conversationUseCase = nil }
			}
		}
	}
}
