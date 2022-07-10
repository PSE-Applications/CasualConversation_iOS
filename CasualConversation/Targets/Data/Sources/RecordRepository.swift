//
//  RecordRepository.swift
//  Domain
//
//  Created by Yongwoo Marco on 2022/07/04.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

import Foundation

public struct RecordRepository: Dependency {
	
	public var dependency: Dependency
	
	public struct Dependency {
		public let repository: FileManagerRepositoryProtocol
		
		public init(repository: FileManagerRepositoryProtocol) {
			self.repository = repository
		}
	}
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}
	
}

extension RecordRepository: RecordRepositoryProtocol {
	
	public var storagePath: URL {
		dependency.repository.directoryPath
	}
	
}
