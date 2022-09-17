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
	@Published var isVocabulary: Bool
	@Published var isEdited: Bool = false
	
	init(dependency: Dependency) {
		self.dependency = dependency
		
		self.original = dependency.item.original
		self.translation = dependency.item.translation
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

extension NoteDetailViewModel {
	
	func updateChanges() {
		guard isEdited else { return }
		let newItem: Note = .init(
			id: self.dependency.item.id,
			original: self.original.trimmingCharacters(in: [" "]),
			translation: self.translation.trimmingCharacters(in: [" "]
															),
			category: self.dependency.item.category,
			references: self.dependency.item.references,
			createdDate: self.dependency.item.createdDate
		)
		self.dependency.useCase.edit(newItem) { error in
			guard error == nil else {
				CCError.log.append(error!)
				return
			}
		}
	}
	
}
