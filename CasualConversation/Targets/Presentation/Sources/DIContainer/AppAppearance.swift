//
//  AppAppearance.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

final class AppAppearance {
	
	static func setup() {
		UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.ccTintColor)
		UITextField.appearance().backgroundColor = UIColor(.ccBgColor)
		UITextView.appearance().backgroundColor = .clear
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
