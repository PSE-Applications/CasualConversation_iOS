//
//  ConversationListViewModel.swift
//  Domain
//
//  Created by Yongwoo Marco on 2022/07/04.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

import Foundation
import Combine

final class ConversationListViewModel: Dependency, ObservableObject {
	
	struct Dependency {
		let useCase: ConversationManagable
	}
	
	let dependency: Dependency
	
	@Published var list: [Conversation] = []
	
	private var cancellables: Set<AnyCancellable> = []
	
	init(dependency: Dependency) {
		self.dependency = dependency
			
		self.dependency.useCase.dataSourcePublisher
			.receive(on: RunLoop.main)
			.assign(to: &self.$list)
	}
	
}

extension ConversationListViewModel {
	
	func removeRows(at offsets: IndexSet) {
		for offset in offsets.sorted(by: >) {
			self.dependency.useCase.delete(list[offset]) { error in
				guard error == nil else {
					print(error?.localizedDescription ?? "\(#function)")
					return
				}
			}
		}
	}
	
}
