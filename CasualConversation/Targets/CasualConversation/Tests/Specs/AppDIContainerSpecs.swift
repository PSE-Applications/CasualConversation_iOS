//
//  AppDIContainerSpecs.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/13.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import CasualConversation
@testable import Presentation

import Quick
import Nimble

class AppDIContainerSpecs: QuickSpec {
	override func spec() {
		describe("인스턴스 객체") {
			var appDIContainer: AppDIContainer!
			beforeEach { appDIContainer = AppDIContainer() }
			afterEach { appDIContainer = nil }
			
			describe("Presentation Layer에 DIContainer 전달 위해서") {
				context("팩토리메서드 호출하면") {
					var presentationDIContainer: PresentationDIContainer!
					beforeEach { presentationDIContainer = appDIContainer.makePresentationDIContainer() }

					it("PresentationDIContainer 생성됨") {
						expect(presentationDIContainer).notTo(beNil())
					}
				}
			}
			
			describe("앱 EntryPoint ContentView를 생성하기 위해서") {
				context("뷰 팩토리메서드 호출하면") {
					var contentView: ContentView!
					beforeEach { contentView = appDIContainer.ContentView() }

					it("MainTabView 생성됨") {
						expect(contentView).notTo(beNil())
					}
				}
			}
			
		}
	}
}
