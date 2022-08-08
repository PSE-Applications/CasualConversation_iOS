//
//  MainTabViewModel.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common
import Domain

import Combine

final class MainTabViewModel: Dependency, ObservableObject {
	
	struct Dependency {

	}
	
	let dependency: Dependency

	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
}
