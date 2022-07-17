//
//  AppDIContainerSpecs.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/13.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import CasualConversation

import Quick
import Nimble

final class AppDIContainerSpecs: QuickSpec {
	
	override func spec() {
		
		var appDIContainer: AppDIContainer!
		
		beforeEach {
			appDIContainer = AppDIContainer()
		}
		
		describe("Factory Methods") {
			
			context("call makePresentationDIContainer()") {
				
				it("return PresentationDIContainer instance") {
					let presentationDIContainer = appDIContainer.makePresentationDIContainer()
					
					expect(presentationDIContainer).notTo(beNil())
				}
			}
			
			context("call PresentationEntryPoint()") {

				it("return MainTabView instance as View") {
					let mainTabView = appDIContainer.PresentationEntryPoint()

					expect(mainTabView).notTo(beNil())
				}
			}
		}
		
	}
	
}
