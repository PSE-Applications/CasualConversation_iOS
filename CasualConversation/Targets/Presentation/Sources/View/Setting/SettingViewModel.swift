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
	
	enum DisplayMode: Int, CaseIterable, CustomStringConvertible {
		case system
		case light
		case dark
		
		var description: String {
			switch self {
			case .system:	return "기기 설정에 따름"
			case .light:	return "라이트 모드"
			case .dark:		return "다크 모드"
			}
		}
	}
	
	struct Dependency {
		
	}
	
	let dependency: Dependency
	
	@Published var lockScreen: Bool
	@Published var displayMode: DisplayMode
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
		self.displayMode = .system
	}
	
}

extension SettingViewModel {
	
	func logoImageName(by colorScheme: ColorScheme) -> String {
		return colorScheme == .light ? "pse_logo" : "pse_logo_border"
	}
	
	func titleImageName(by colorScheme: ColorScheme) -> String {
		return colorScheme == .light ? "pse_title" : "pse_title_border"
	}
	
}
