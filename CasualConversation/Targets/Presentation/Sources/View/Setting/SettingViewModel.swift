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

final class SettingViewModel: Dependency, ObservableObject {
	
	struct Dependency {
		
	}
	
	let dependency: Dependency
	private let preference: Preference = .shared
	
	@Published var lockScreen: Bool
	@Published var displayMode: DisplayMode {
		willSet { preference.displayMode = newValue }
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
				print("\(error)")
			}
		}
	}
	
	init(dependency: Dependency) {
		self.dependency = dependency
		
		self.lockScreen = false
		self.displayMode = preference.displayMode
	}
	
}

extension SettingViewModel {
	
	func logoImageName(by colorScheme: ColorScheme) -> String {
		if let userSelection = preference.colorScheme {
			return userSelection == .light ? "pse_logo" : "pse_logo_border"
		} else {
			return colorScheme == .light ? "pse_logo" : "pse_logo_border"
		}
	}
	
	func titleImageName(by colorScheme: ColorScheme) -> String {
		if let userSelection = preference.colorScheme {
			return userSelection == .light ? "pse_title" : "pse_title_border"
		} else {
			return colorScheme == .light ? "pse_title" : "pse_title_border"
		}
	}
	
}
