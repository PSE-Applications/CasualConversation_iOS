//
//  MockRecordDataController.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/13.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Domain

import Foundation
import Common

struct MockRecordDataController {
	
	private var directory = FileManager.default.temporaryDirectory
	
}

extension MockRecordDataController: RecordDataControllerProtocol {
	
	func requestNewFilePath() -> URL {
		return URL(fileURLWithPath: "test")
	}
	
	func requestRecordData(from filePath: URL) -> Data? {
		return try? Data(contentsOf: filePath)
	}
	
	func deleteRecordData(from filePath: URL, completion: (CCError?) -> Void) {
		completion(nil)
	}
	
}
