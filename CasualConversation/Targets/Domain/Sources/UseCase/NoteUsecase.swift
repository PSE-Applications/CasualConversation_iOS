//
//  NoteUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common

import Foundation


public protocol NoteUseCaseManagable {
	// TODO: Conversation CRUD
}

public final class NoteUseCase: Dependency, NoteUseCaseManagable {
	
	public struct Dependecy {
		let repository: NoteRepositoryProtocol
		
		public init(repository: NoteRepositoryProtocol) {
			self.repository = repository
		}
	}
	
	public let dependency: Dependecy
	
	public init(dependency: Dependecy) {
		self.dependency = dependency
	}
	
}

