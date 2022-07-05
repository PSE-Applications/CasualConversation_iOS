//
//  MainTabViewModel.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common
import Domain

import Foundation

public final class MainTabViewModel: Dependency, ObservableObject {
	
	public struct Dependency {
		public init() {
			
		}
	}
	
	public let dependency: Dependency

	public init(dependency: Dependency) {
		self.dependency = dependency
	}
	
}
