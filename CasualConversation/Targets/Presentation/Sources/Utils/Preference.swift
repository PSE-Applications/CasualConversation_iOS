//
//  Preference.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/09/13.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

protocol UserDefaultsKey {
	static var key: String { get }
}

extension UserDefaultsKey {
	static var key: String { .init(describing: Self.self) }
}

enum DisplayMode: String, CaseIterable, CustomStringConvertible, UserDefaultsKey {
	case system, light, dark
	
	var description: String {
		switch self {
		case .system:	return "기기 설정에 따름"
		case .light:	return "라이트 모드"
		case .dark:		return "다크 모드"
		}
	}
}

enum SkipTime: Double, CaseIterable, CustomStringConvertible, UserDefaultsKey {
	case five = 5.0
	case ten = 10.0
	case fifteen = 15.0
	case thirty = 30.0
	
	var description: String { "\(Int(self.rawValue))" }
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
	var skipTime: SkipTime {
		didSet { userDefault.set(skipTime.rawValue, forKey: SkipTime.key) }
	}
	var displayMode: DisplayMode {
		willSet { objectWillChange.send() }
		didSet { userDefault.set(displayMode.rawValue, forKey: DisplayMode.key) }
	}
	
	private override init() {
		let skipTimeValue = userDefault.double(forKey: SkipTime.key)
		let screenModeValue = userDefault.string(forKey: DisplayMode.key) ?? "system"
	   
		self.isLockScreen = userDefault.bool(forKey: "isLockScreen")
		self.skipTime = .init(rawValue: skipTimeValue) ?? .five
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
