//
//  NoteDetailViewModel.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/10.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

import SwiftUI

final class NoteDetailViewModel: Dependency, ObservableObject {
	
	struct Dependency {
		let useCase: NoteManagable
		let item: Note
	}
	
	let dependency: Dependency
	
	@Published var original: String
	@Published var translation: String
	@Published var pronunciation: String
	@Published var isVocabulary: Bool
	
	init(dependency: Dependency) {
		self.dependency = dependency
		
		self.original = dependency.item.original
		self.translation = dependency.item.translation
		self.pronunciation = ""
		self.isVocabulary = dependency.item.category == .vocabulary
	}
	
}

extension NoteDetailViewModel {
	
	var navigationTitleIconImageName: String {
		self.isVocabulary ? "textformat.abc" : "text.bubble.fill"
	}
	var navigationTitle: String {
		self.isVocabulary ? "Vocabulary" : "Sentense"
	}
	
}

#if DEBUG

struct DebugNoteUseCase: NoteManagable {
	
	func list() -> [Note] {
		[]
	}
	
	func add(item: Note, completion: (CCError?) -> Void) {
		
	}
	
	func edit(newItem: Note, completion: (CCError?) -> Void) {
		
	}
	
	func delete(item: Note, completion: (CCError?) -> Void) {
		
	}

}

extension NoteDetailViewModel {
	
	static var previewViewModels: [NoteDetailViewModel] {
		[
			.init(dependency: .init(
				useCase: DebugNoteUseCase(),
				item: .init(
						id: .init(),
						original: "Way out",
						translation: "나가는 길",
						category: .vocabulary,
						references: [],
						createdDate: Date()
					)
				)
			),
			.init(dependency: .init(
				useCase: DebugNoteUseCase(),
				item: .init(
						id: .init(),
						original: "Hi, I'm Marco.\nI'm glad meet you.\nI'd like to talk to you.",
						translation: "안녕하세요, 저는 마르코입니다.\n만나서 반갑습니다.\n이야기하기를 바랬어요.",
						category: .sentece,
						references: [],
						createdDate: Date()
					)
				)
			)
		]
	}
	
}

#endif
