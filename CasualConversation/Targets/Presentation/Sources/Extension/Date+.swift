//
//  Date+.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/08.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Foundation

extension Date {
	
	static let formatter = DateFormatter()
	
	var formattedString: String {
		let firstLanguageId = Locale.preferredLanguages[0]
		let deviceLocale = Locale(identifier: firstLanguageId)
		Self.formatter.locale = deviceLocale
		Self.formatter.dateFormat = "yyyy.MM.dd HH:mm"
		return Self.formatter.string(from: self)
	}
	
}
