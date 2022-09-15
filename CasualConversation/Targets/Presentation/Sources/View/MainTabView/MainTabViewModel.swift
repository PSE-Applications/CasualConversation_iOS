//
//  MainTabViewModel.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/14.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common

import SwiftUI

final class MainTabViewModel: ObservableObject {
	
	enum Tab {
		case conversations, notes
	}
	
}

extension MainTabViewModel {
	
	func title(by tab: Tab) -> String {
		tab == .conversations ? "Conversations" : "Notes"
	}
	
	func tabItemImageName(by tab: Tab) -> String {
		switch tab {
		case .conversations: 	return "rectangle.stack.badge.play.fill"
		case .notes:			return "checklist"
		}
	}
	
	func tabTintColor(by tab: Tab) -> (Color, Color) {
		switch tab {
		case .conversations: 	return (Color.logoLightRed, Color.logoDarkRed)
		case .notes: 			return (Color.logoLightBlue, Color.logoDarkBlue)
		}
	}
	
	func tabItemTintColor(from tab: Tab, by selectedIndex: Tab) -> Color {
		var tintColor: (light: Color, dark: Color) { tabTintColor(by: tab) }
		return tab == selectedIndex ? tintColor.light : tintColor.dark
	}
	
}
