//
//  AppAppearance.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

final class AppAppearance {
	
	@Environment(\.colorScheme) static var colorScheme

	static func setup() {
		UISegmentedControl.appearance().selectedSegmentTintColor = UIColor
			.init(self.colorScheme == .dark ? .logoDarkGreen : .logoLightGreen)
	}
	
}

// MARK: - Example
//extension UINavigationController {
//
//	@objc override open var preferredStatusBarStyle: UIStatusBarStyle {
//		return .lightContent
//	}
//
//}
