//
//  NoteSetRowViewModel.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/13.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

import SwiftUI

final class NoteSetRowViewModel: Dependency, ObservableObject {
	
	struct Dependency {
		let item: Note
	}
	
	let dependency: Dependency
	
	@Published var category: Note.Category
	@Published var original: String
	@Published var translation: String
	@Published var pronunciation: String
	
	init(dependency: Dependency) {
		self.dependency = dependency
		
		self.category = dependency.item.category
		self.original = dependency.item.original
		self.translation = dependency.item.translation
		self.pronunciation = "" // TODO: Model 추가 필요 - dependency.item.pronunciation
	}
}

#if DEBUG

extension NoteSetRowViewModel {
	
	static let debugViewModels: [NoteSetRowViewModel] = [
		.init(dependency: .init(
			item: .init(
				id: .init(),
				original: "Hello",
				translation: "안녕",
				category: .vocabulary,
				references: [],
				createdDate: Date()
				)
			)
		),
		.init(dependency: .init(
			item: .init(
				id: .init(),
				original: "Nice to meet you.",
				translation: "",
				category: .sentece,
				references: [],
				createdDate: Date()
				)
			)
		)
	]
	
}

#endif
