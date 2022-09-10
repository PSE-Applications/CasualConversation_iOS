//
//  Date+.swift
//  Data
//
//  Created by Yongwoo Marco on 2022/09/09.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Foundation

extension Date {
	
	static let formatter = DateFormatter()
	
	var formattedForFileName: String {
		Self.formatter.dateFormat = "yyyyMMdd_HHmm"
		return Self.formatter.string(from: self)
	}
	
}
