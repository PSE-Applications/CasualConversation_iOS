//
//  RecordService.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common

import Foundation

public protocol RecordServiceProtocol {
	func startRecording()
	func pauseRecording()
	func stopRecording()
}

public struct RecordService: Dependency {
	
	public var dependency: Dependency
	
	public struct Dependency {
		let repository: RecordRepositoryProtocol
		
		public init(repository: RecordRepositoryProtocol) {
			self.repository = repository
		}
	}
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}

}

extension RecordService: RecordServiceProtocol {
	
	public func startRecording() {

	}
	
	public func pauseRecording() {
		
	}
	
	public func stopRecording() {
		
	}
	
	
}
