//
//  NoteUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common

public protocol NoteUseCaseManagable {
	// TODO: Conversation CRUD
}

public final class NoteUseCase: Dependency, NoteUseCaseManagable {
	
	public enum Filter {
		case all
		case selected(Conversation)
	}
	
	public struct Dependecy {
		let repository: NoteRepositoryProtocol
		var filter: Filter
		
		public init(
			repository: NoteRepositoryProtocol,
			filter: Filter
		) {
			self.repository = repository
			self.filter = filter
		}
	}
	
	public var dependency: Dependecy
	
	public init(dependency: Dependecy) {
		self.dependency = dependency
	}
	
	public func changeFilter(to filter: Filter) {
		self.dependency.filter = filter
	}
	
}

