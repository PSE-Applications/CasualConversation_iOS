//
//  Color+.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/08/08.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

extension Color {
	
	static let ccTintColor = Self("CCTintColor")
	static let ccAccentColor = Self("CCAccentColor")
	static let ccBgColor = Self("CCBackgroundColor")
	static let ccGroupBgColor = Self("CCGroupBackgroundColor")
	
	static let logoLightRed = Color(hex: "#E30111")
	static let logoDarkRed = Color(hex: "#600000")
	static let logoLightGreen = Color(hex: "#9DC30A")
	static let logoDarkGreen = Color(hex: "#02681B")
	static let logoLightBlue = Color(hex: "#0DB0EA")
	static let logoDarkBlue = Color(hex: "#07387B")
	static let darkRecordColor = Color(hex: "#1C1E23")
	static let lightRecordColor = Color(hex: "#282A30")
	static let iconMainColor = Color(hex: "#FEB400")
	
	init(hex: String) {
		let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
		var int: UInt64 = 0
		Scanner(string: hex).scanHexInt64(&int)
		let a, r, g, b: UInt64
		switch hex.count {
		case 3: // RGB (12-bit)
			(a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
		case 6: // RGB (24-bit)
			(a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
		case 8: // ARGB (32-bit)
			(a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
		default:
			(a, r, g, b) = (1, 1, 1, 0)
		}

		self.init(
			.sRGB,
			red: Double(r) / 255,
			green: Double(g) / 255,
			blue:  Double(b) / 255,
			opacity: Double(a) / 255
		)
	}
	
}
