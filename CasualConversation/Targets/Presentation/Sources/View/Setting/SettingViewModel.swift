//
//  SettingViewModel.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/14.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common

import SwiftUI
import MessageUI
import StoreKit

final class SettingViewModel: ObservableObject {
	
	@Published var isLockScreen: Bool {
		willSet { Preference.shared.isLockScreen = newValue }
	}
	@Published var skipTime: SkipTime {
		willSet { Preference.shared.skipTime = newValue }
	}
	@Published var displayMode: DisplayMode {
		willSet { Preference.shared.displayMode = newValue }
	}
	@Published var mailSendedResult: Result<MFMailComposeResult,Error>? {
		// TODO: Mail 완료 후 처리 필요
		willSet {
			guard let result = newValue else {
				return
			}
			switch result {
			case .success(let mailComposeResult):
				print("\(mailComposeResult)")
			case .failure(let error):
				CCError.log.append(.catchError(error))
			}
		}
	}
	@Published var version: String
	
	init() {		
		self.isLockScreen = Preference.shared.isLockScreen
		self.skipTime = Preference.shared.skipTime
		self.displayMode = Preference.shared.displayMode
		self.version = Preference.shared.appVersion
	}
	
}

extension SettingViewModel {
	
	func logoImageName(by colorScheme: ColorScheme) -> String {
		if let userSelection = Preference.shared.colorScheme {
			return userSelection == .light ? "pse_logo" : "pse_logo_border"
		} else {
			return colorScheme == .light ? "pse_logo" : "pse_logo_border"
		}
	}
	
	func titleImageName(by colorScheme: ColorScheme) -> String {
		if let userSelection = Preference.shared.colorScheme {
			return userSelection == .light ? "pse_title" : "pse_title_border"
		} else {
			return colorScheme == .light ? "pse_title" : "pse_title_border"
		}
	}
	
}

extension SettingViewModel {
	
	func requestReview() {
		guard let currentScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
			CCError.log.append(.log("UNABLE TO GET CURRENT SCENE"))
			  return
		}
		SKStoreReviewController.requestReview(in: currentScene)
	}
	
}
