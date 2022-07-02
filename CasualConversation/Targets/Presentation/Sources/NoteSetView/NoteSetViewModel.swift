//
//  NoteSetViewModel.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Foundation

final class NoteSetViewModel: ObservableObject {
	
	struct Dependency {
		let useCase: NoteUseCaseManagable
	}
	
	private let dependency: Dependency
	
	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
}
