//
//  FileManagerRepository.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Foundation

public struct FileManagerRepository {
	
	private var baseDirectory = FileManager.default.temporaryDirectory
	
	public init() {
		
	}
	
}

extension FileManagerRepository: FileManagerRepositoryProtocol {
	
	public var directoryPath: URL {
		baseDirectory
	}
	
}
