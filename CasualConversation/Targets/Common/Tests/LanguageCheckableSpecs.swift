//
//  LanguageCheckableSpecs.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/13.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Common

import Quick
import Nimble

class LanguageCheckableSpecs: QuickSpec {
	
	struct Adapter: LanguageCheckable { }
	
	override func spec() {
		describe("프로토콜 채택한 개체") {
			var adaptedInstance: Adapter!
			beforeEach { adaptedInstance = .init() }
			afterEach { adaptedInstance = nil }
			
			describe("공백 1개 한글 문자열을 매개변수로") {
				var text: String!
				beforeEach { text = "한글 문자열" }
				afterEach { text = nil }
				
				context("containsKorean 메서드 호출하면") {
					var result: Bool!
					beforeEach { result = adaptedInstance.containsKorean(by: text) }
					afterEach { result = nil }

					it("true 반환") {
						expect(result).to(equal(true))
					}
				}
				
				context("containsEnglish 메서드 호출하면") {
					var result: Bool!
					beforeEach { result = adaptedInstance.containsEnglish(by: text) }
					afterEach { result = nil }

					it("false 반환") {
						expect(result).to(equal(false))
					}
				}
				
				context("hasSpace 메서드 count 1 매개변수 호출하면") {
					var result: Bool!
					beforeEach { result = adaptedInstance.hasSpace(by: text, count: 1) }
					afterEach { result = nil }

					it("true 반환") {
						expect(result).to(equal(true))
					}
				}
			}
			
			describe("한글과 영어가 섞인 문자열을 매개변수로") {
				var text: String!
				beforeEach { text = "한글 English" }
				afterEach { text = nil }
				
				context("containsKorean 메서드 호출하면") {
					var result: Bool!
					beforeEach { result = adaptedInstance.containsKorean(by: text) }
					afterEach { result = nil }

					it("false 반환") {
						expect(result).to(equal(true))
					}
				}
				
				context("containsEnglish 메서드 호출하면") {
					var result: Bool!
					beforeEach { result = adaptedInstance.containsEnglish(by: text) }
					afterEach { result = nil }

					it("true 반환") {
						expect(result).to(equal(true))
					}
				}
				
				context("hasSpace 메서드 more 1 매개변수 호출하면") {
					var result: Bool!
					beforeEach { result = adaptedInstance.hasSpace(by: text, count: 1) }
					afterEach { result = nil }

					it("true 반환") {
						expect(result).to(equal(true))
					}
				}
			}
			
		}
	}
}
