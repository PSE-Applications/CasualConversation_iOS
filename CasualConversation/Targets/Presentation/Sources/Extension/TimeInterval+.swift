//
//  TimeInterval+.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/08/09.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Foundation

extension TimeInterval {
	
	static let formmatter = DateComponentsFormatter()
	
	var toTimeString: String {
		Self.formmatter.allowedUnits = [.hour, .minute, .second]
		if self.isZero {
			return "00:00:00"
		} else {
			return Self.formmatter.string(from: self) ?? "00:00:00"
		}
	}
	
}
