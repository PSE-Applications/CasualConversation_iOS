//
//  FileManagerRepository.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Foundation

public protocol FileManagerRepositoryProtocol {
	var baseDirectory: URL { get }
	func contents(atPath: String) -> Data?
}

public struct FileManagerRepository {
	
	private var fileManager = FileManager.default
	
	public init() { }
	
}

extension FileManagerRepository: FileManagerRepositoryProtocol {
	
	public var baseDirectory: URL {
		fileManager.temporaryDirectory
	}
	
	public func contents(atPath: String) -> Data? {
		return fileManager.contents(atPath: atPath)
	}
	
}
