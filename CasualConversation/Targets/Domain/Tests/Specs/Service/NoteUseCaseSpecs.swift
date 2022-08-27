//
//  NoteUseCaseSpecs.swift
//  DomainTests
//
//  Created by Yongwoo Marco on 2022/07/20.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Common
@testable import Domain

import Quick
import Nimble

extension NoteUseCase {
	fileprivate static func sut(case type: Bool, error: CCError? = nil) -> NoteUseCase {
		.init(dependency: .init(
				repository: MockNoteDataController(case: type, error: error),
				filter: .all
			)
		)
	}
}

final class NoteUseCaseSpecs: QuickSpec {
	override func spec() {
		describe("인스턴스 객체") {
			var noteUseCase: NoteUseCase!
			
			describe("성공케이스") {
				beforeEach { noteUseCase = .sut(case: true) }
				afterEach { noteUseCase = nil }
				
				describe("NoteUseCaseManagable 추상화하고") {
					var managable: NoteManagable!
					beforeEach { managable = noteUseCase }
					afterEach { managable = noteUseCase	}
					
					describe("Note 객체를") {
						var newItem: Note!
						beforeEach { newItem = .empty }
						afterEach { newItem = nil }
						
						context("추가하면") {
							var parameter: CCError!
							beforeEach {
								managable.add(item: newItem) { error in
									parameter = error
								}
							}
							afterEach { parameter = nil }
							
							it("completion 매개변수 nil 받음") {
								expect(parameter).to(beNil())
							}
						}
						
						context("변경하면") {
							var parameter: CCError!
							beforeEach {
								managable.edit(newItem: .init(
									id: newItem.id,
									original: "Edited Original",
									translation: "변경된 번역",
									category: .vocabulary,
									references: [],
									createdDate: newItem.createdDate)
								) { error in
									parameter = error
								}
							}
							afterEach { parameter = nil }
							
							it("completion 매개변수 nil 받음") {
								expect(parameter).to(beNil())
							}
						}
						
						context("삭제하면") {
							var parameter: CCError!
							beforeEach {
								managable.delete(item: newItem) { error in
									parameter = error
								}
							}
							afterEach { parameter = nil }
							
							it("completion 매개변수 nil 받음") {
								expect(parameter).to(beNil())
							}
						}
					}
				}
			}
		}
	}
}
