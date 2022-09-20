//
//  NoteSetViewModel.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common
import Domain

import SwiftUI

final class NoteSetViewModel: Dependency, ObservableObject {
	
	struct Dependency {
		let useCase: NoteManagable
	}
	
	let dependency: Dependency
	
	@Published var list: [Note] = []
	
	init(dependency: Dependency) {
		self.dependency = dependency
		
		self.dependency.useCase.dataSourcePublisher
			.assign(to: &self.$list)
	}
	
}

extension NoteSetViewModel {
	
	func removeRows(at offsets: IndexSet) {
		for offset in offsets.sorted(by: >) {
			self.dependency.useCase.delete(item: list[offset]) { error in
				guard error == nil else {
					CCError.log.append(error!)
					return
				}
			}
		}
	}
	
}
