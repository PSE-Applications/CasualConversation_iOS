//
//  RecordDataController.swift
//  Domain
//
//  Created by Yongwoo Marco on 2022/07/04.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

import Foundation

public struct RecordDataController: Dependency {
	
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

extension RecordDataController: RecordDataControllerProtocol {
		
	public func requestNewFilePath() -> URL {
		let baseDirectoryURL = dependency.repository.baseDirectory
		let newfileName = Date().formattedForFileName
		let newFileURL = baseDirectoryURL
			.appendingPathComponent(newfileName)
			.appendingPathExtension("m4a") // TODO: 녹음파일형식 고민하기 "caf"
		return newFileURL
	}
	
	public func requestRecordData(from filePath: URL) -> Data? {
		guard let audioData = dependency.repository.contents(atPath: filePath.path) else {
			CCError.log.append(.log("\(#function) 불러오기 실패"))
			return nil
		}
		return audioData
	}
	
	public func deleteRecordData(from filePath: URL, completion: (CCError?) -> Void) {
		self.dependency.repository.deleteContent(atPath: filePath.path) { error in
			guard error == nil else {
				completion(error)
				return
			}
			completion(nil)
		}
	}
	
}
