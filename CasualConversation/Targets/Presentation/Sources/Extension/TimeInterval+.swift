//
//  TimeInterval+.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/08/09.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Foundation

extension TimeInterval {
	
	static let formmater = DateComponentsFormatter()
	
	var toTimeString: String {
		return Self.formmater.string(from: self) ?? "00:00"
	}
	
}
