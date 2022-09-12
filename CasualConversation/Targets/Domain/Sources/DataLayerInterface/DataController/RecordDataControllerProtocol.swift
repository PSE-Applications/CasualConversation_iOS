//
//  RecordDataControllerProtocol.swift
//  Domain
//
//  Created by Yongwoo Marco on 2022/07/04.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Foundation.NSURL

public protocol RecordDataControllerProtocol {
	func requestNewFilePath() -> URL
	func requestRecordData(from filePath: URL) -> Data?
	func deleteRecordData(from filePath: URL, completion: (CCError?) -> Void)
}
