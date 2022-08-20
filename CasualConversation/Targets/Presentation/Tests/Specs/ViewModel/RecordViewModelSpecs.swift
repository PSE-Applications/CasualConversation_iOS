//
//  RecordViewModelSpecs.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/08/20.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Presentation

import Quick
import Nimble

import Foundation

final class RecordViewModelSpecs: QuickSpec {
	override func spec() {
		describe("인스턴스 객체") {
			var container: PresentationDIContainer!
			var viewModel: RecordViewModel!
			
			beforeEach {
				container = .sut
				viewModel = container.RecordView().viewModel
			}
			afterEach {
				container = nil
				viewModel = nil
			}
			
			// TODO: Internal Function UnitTest 추가필요
	
		}
	}
}

