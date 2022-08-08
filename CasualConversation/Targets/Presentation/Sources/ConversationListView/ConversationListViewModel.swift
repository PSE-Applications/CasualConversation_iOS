//
//  ConversationListViewModel.swift
//  Domain
//
//  Created by Yongwoo Marco on 2022/07/04.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

import Combine

public final class ConversationListViewModel: Dependency {
	
	public struct Dependency {
		let useCase: ConversationManagable
		
		public init(useCase: ConversationManagable) {
			self.useCase = useCase
		}
	}
	
	public let dependency: Dependency
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}
	
}

extension ConversationListViewModel {
	
	var list: [Conversation] { // TODO: DataBinding 형태로 변경 필요
		self.dependency.useCase.list
	}
	
	func remove(at index: Int) {
		self.dependency.useCase.delete(list[index]) { error in
			// TODO: 삭제 프로세스 고민 필요
		}
	}
	
}
