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

public final class ConversationListViewModel: Dependency, ObservableObject {
	
	public struct Dependency {
		let useCase: ConversationUseCaseManagable
		
		public init(useCase: ConversationUseCaseManagable) {
			self.useCase = useCase
		}
	}
	
	public let dependency: Dependency
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}
	
}
