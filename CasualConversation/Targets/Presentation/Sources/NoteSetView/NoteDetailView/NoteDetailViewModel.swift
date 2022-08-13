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
