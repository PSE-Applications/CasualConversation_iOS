//
//  SelectionViewModelSpecs.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/08/20.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Presentation

import Quick
import Nimble

import Foundation
import SwiftUI

final class SelectionViewModelSpecs: QuickSpec {
	override func spec() {
		describe("인스턴스 객체") {
			var container: PresentationDIContainer!
			var viewModel: SelectionViewModel!
			
			beforeEach {
				container = .sut
				viewModel = container.SelectionView(selected: .empty).viewModel
			}
			afterEach {
				container = nil
				viewModel = nil
			}
			
			describe("View Component Selection Methods") {
				describe("editToggleLabel 메서드 호출할떄") {
					context("매개변수 true 이면") {
						var returnValue: String!
						beforeEach {
							returnValue = viewModel.editToggleLabel(by: true)
						}
						afterEach { returnValue = nil }
						
						it("'완료' 반환") {
							expect(returnValue).to(equal("완료"))
						}
					}
					
					context("매개변수 false 이면") {
						var returnValue: String!
						beforeEach {
							returnValue = viewModel.editToggleLabel(by: false)
						}
						afterEach { returnValue = nil }
						
						it("'수정' 반환") {
							expect(returnValue).to(equal("수정"))
						}
					}
				}
				
				describe("isEditingShadowColor 메서드 호출할때") {
					context("매개변수 true 이면") {
						var returnValue: Color!
						beforeEach {
							returnValue = viewModel.isEditingShadowColor(by: true)
						}
						afterEach { returnValue = nil }
						
						it("Color.clear 반환") {
							expect(returnValue).to(equal(Color.clear))
						}
					}
					
					context("매개변수 false 이면") {
						var returnValue: Color!
						beforeEach {
							returnValue = viewModel.isEditingShadowColor(by: false)
						}
						afterEach { returnValue = nil }
						
						it("Color.gray 반환") {
							expect(returnValue).to(equal(Color.gray))
						}
					}
				}
			}
			
			describe("'This is a test Sentence` 문장을 추가할때") {
				beforeEach {
					viewModel.inputText = "This is a test Sentence"
				}
				describe("입력조건 '영어' '문장' 이면") {
					beforeEach {
						viewModel.language = .original
						viewModel.category = .sentense
					}

					context("addNote 메서드 호출 시") {
						var returnValue: Bool!
						beforeEach {
							returnValue = viewModel.addNote()
						}
						
						it("true 반환") {
							expect(returnValue).to(beTrue())
						}
					}
				}
				
				describe("입력조건 '한글' '단어' 이면") {
					beforeEach {
						viewModel.language = .translation
						viewModel.category = .vocabulary
					}

					context("addNote 메서드 호출 시") {
						var returnValue: Bool!
						beforeEach {
							returnValue = viewModel.addNote()
						}
						
						it("false 반환") {
							expect(returnValue).to(beFalse())
						}
					}
				}
			}
		}
	}
}

