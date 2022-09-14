//
//  Preference.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/09/13.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

enum DisplayMode: String, CaseIterable, CustomStringConvertible {
	case system, light, dark

	static var key: String { .init(describing: Self.self) }
	
	var description: String {
		switch self {
		case .system:	return "기기 설정에 따름"
		case .light:	return "라이트 모드"
		case .dark:		return "다크 모드"
		}
	}
}

final class Preference: NSObject, ObservableObject {
	
	static let shared: Preference = Preference()
	private let userDefault: UserDefaults = UserDefaults.standard
	
	var isLockScreen: Bool {
		didSet {
			UIApplication.shared.isIdleTimerDisabled = isLockScreen
			userDefault.set(isLockScreen, forKey: "isLockScreen")
		}
	}
	var displayMode: DisplayMode {
		willSet { objectWillChange.send() }
		didSet { userDefault.set(displayMode.rawValue, forKey: DisplayMode.key) }
	}
	
	private override init() {
		let screenModeValue = userDefault.string(forKey: DisplayMode.key) ?? "system"
	   
		self.isLockScreen = userDefault.bool(forKey: "isLockScreen")
		self.displayMode = .init(rawValue: screenModeValue) ?? .system
	}
	
}

extension Preference {
	
	var colorScheme: ColorScheme? {
		switch displayMode {
		case .system: 	return nil
		case .light: 	return .light
		case .dark:		return .dark
		}
	}
	
}
