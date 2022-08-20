//
//  NoteDataControllerSpecs.swift
//  Data
//
//  Created by Yongwoo Marco on 2022/08/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Data
@testable import Common
@testable import Domain

import Quick
import Nimble

extension NoteDataController {
	fileprivate static var sut: Self {
		Self.init(dependency: .init(coreDataStack: TestCoreDataStack())
		)
	}
}

final class NoteDataControllerSpecs: QuickSpec {
	override func spec() {
		describe("인스턴스 객체가") {
			var noteRepository: NoteDataControllerProtocol!
			beforeEach { noteRepository = NoteDataController.sut }
			afterEach { noteRepository = nil }
			
			describe("새 데이터를") {
				var newItem: Note!
				beforeEach { newItem = .empty }
				afterEach { newItem = nil }
				
				context("create 메서드로 추가하면") {
					var parameter: CCError?
					beforeEach {
						noteRepository.create(newItem) { error in
							parameter = error
						}
					}
					afterEach { parameter = nil	}
					
					it("completion 매개변수 nil 받음") {
						expect(parameter).to(beNil())
					}
				}
				
				context("추가 후 fetchRequest 메서드로 데이터 불러오기 시도하면") {
					var list: [Note]?
					beforeEach {
						noteRepository.create(newItem, completion: { _ in })
						list = noteRepository.fetch(filter: nil)
					}
					afterEach { list = nil }
					
					it("반환값 1개 존재함") {
						expect(list).notTo(beNil())
						expect(list?.count).to(be(1))
					}
				}
				
				context("추가 후 delete 메서드로 제거하고 데이터 불러오기 시도하면") {
					var list: [Note]?
					var parameter: CCError?
					beforeEach {
						noteRepository.create(newItem, completion: { _ in })
						noteRepository.delete(newItem) { error in
							parameter = error
						}
						list = noteRepository.fetch(filter: nil)
					}
					afterEach { list = nil }
					
					it("completion 매개변수 nil 받고, 반환값 0개 존재") {
						expect(parameter).to(beNil())
						expect(list).notTo(beNil())
						expect(list?.count).to(be(0))
					}
				}
				
				context("추가 후 update 메서드로 변경하면 하고 데이터 불러오기 시도하면") {
					var list: [Note]?
					var parameter: CCError?
					beforeEach {
						noteRepository.create(newItem, completion: { _ in })
						noteRepository.update(after: .init(
							id: newItem.id,
							original: "new Original",
							translation: newItem.translation,
							category: newItem.category,
							references: newItem.references,
							createdDate: newItem.createdDate
						)) { error in
							parameter = error
						}
						list = noteRepository.fetch(filter: nil)
					}
					afterEach { list = nil }
					
					it("completion 매개변수 nil 받고, 기존값과 다름") {
						expect(parameter).to(beNil())
						expect(list).notTo(beNil())
						expect(list?.count).to(be(1))
						expect(list?.first!.original).notTo(be(newItem.original))
					}
				}
			}
		}
	}
}

