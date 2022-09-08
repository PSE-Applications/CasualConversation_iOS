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
	
	enum TimeConstant {
	  static let secsPerMin = 60
	  static let secsPerHour = TimeConstant.secsPerMin * 60
	}
	
	var formattedToDisplayTime: String {
	  var seconds = Int(ceil(self))
	  var hours = 0
	  var mins = 0

	  if seconds > TimeConstant.secsPerHour {
		hours = seconds / TimeConstant.secsPerHour
		seconds -= hours * TimeConstant.secsPerHour
	  }

	  if seconds > TimeConstant.secsPerMin {
		mins = seconds / TimeConstant.secsPerMin
		seconds -= mins * TimeConstant.secsPerMin
	  }

	  var formattedString = ""
	  if hours > 0 {
		formattedString = "\(String(format: "%02d", hours)):"
	  }
	  formattedString += "\(String(format: "%02d", mins)):\(String(format: "%02d", seconds))"
	  return formattedString
	}
	
}
