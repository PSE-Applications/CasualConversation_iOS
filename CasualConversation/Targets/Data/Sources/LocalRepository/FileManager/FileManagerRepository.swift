//
//  FileManagerRepository.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Foundation

public protocol FileManagerRepositoryProtocol {
	var directoryPath: URL { get }
}

public struct FileManagerRepository {
	
	private var baseDirectory = FileManager.default.temporaryDirectory // TODO: 저장위치 선정 필요함 (임시 선정 - temporaryDirectory)
	
	public init() { }
	
}

extension FileManagerRepository: FileManagerRepositoryProtocol {
	
	public var directoryPath: URL {
		baseDirectory
	}
	
}
