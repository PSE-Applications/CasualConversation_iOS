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
		let audioService: RecordManagable
	}
	
	let dependency: Dependency
	
	@Published var list: [Conversation] = []
	
	private var cancellables: Set<AnyCancellable> = []
	
	init(dependency: Dependency) {
		self.dependency = dependency
			
		self.dependency.useCase.dataSourcePublisher
			.assign(to: &self.$list)
	}
	
}

extension ConversationListViewModel {
	
	func removeRows(at offsets: IndexSet) {
		for offset in offsets.sorted(by: >) {
			let item = list[offset]
			self.dependency.audioService.removeRecordFile(from: item.recordFilePath) { error in
				if error != nil {
					CCError.log.append(error!)
				}
			}
			self.dependency.useCase.delete(item) { error in
				guard error == nil else {
					CCError.log.append(error!)
					return
				}
			}
		}
	}
	
}
