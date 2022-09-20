//
//  LanguageCheckable.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/08/19.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Foundation

public protocol LanguageCheckable { }

extension LanguageCheckable {
	 
	public func containsKorean(by text: String) -> Bool {
		return text.range(of: "[가-힣]", options: .regularExpression) != nil
	}
	
	public func containsEnglish(by text: String) -> Bool {
		return text.range(of: "[A-Za-z]", options: .regularExpression) != nil
	}
	
	public func hasSpace(by text: String, more count: Int) -> Bool {
		let trimmedText = text.trimmingCharacters(in: [" "])
		return trimmedText.components(separatedBy:  " ").count > count
	}
	
}
