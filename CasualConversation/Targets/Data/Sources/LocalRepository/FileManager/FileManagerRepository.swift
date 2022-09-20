//
//  FileManagerRepository.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common

import Foundation

public protocol FileManagerRepositoryProtocol {
	var baseDirectory: URL { get }
	func contents(atPath: String) -> Data?
	func deleteContent(atPath: String, completion: (CCError?) -> Void)
}

public struct FileManagerRepository {
	
	private var fileManager = FileManager.default
	private let documentsURL: URL
	private let recordsDirectoryURL: URL
	
	public init() {
		self.documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
		self.recordsDirectoryURL = documentsURL.appendingPathComponent("Records")
		
		do {
			try fileManager.createDirectory(
				at: self.recordsDirectoryURL,
				withIntermediateDirectories: true,
				attributes: nil)
		} catch {
			CCError.log.append(.log("\(Self.self) \(#function) - 디렉토리 생성 실패"))
		}
	}
	
}

extension FileManagerRepository: FileManagerRepositoryProtocol {
	
	public var baseDirectory: URL {
		self.recordsDirectoryURL
	}

	public func contents(atPath: String) -> Data? { // TODO: 매개변수 File 명으로 변경
		let fileName = atPath.components(separatedBy: "/").last!
		let path = self.recordsDirectoryURL.appendingPathComponent(fileName)
		return fileManager.contents(atPath: path.path)
	}
		
	public func deleteContent(atPath: String, completion: (CCError?) -> Void) {
		let fileName = atPath.components(separatedBy: "/").last!
		let path = self.recordsDirectoryURL.appendingPathComponent(fileName)
		guard fileManager.fileExists(atPath: path.path) else {
			completion(.persistenceFailed(reason: .fileNotExists))
			return
		}
		do {
			try fileManager.removeItem(at: path)
			completion(nil)
		} catch {
			completion(.catchError(error))
		}
	}

}
