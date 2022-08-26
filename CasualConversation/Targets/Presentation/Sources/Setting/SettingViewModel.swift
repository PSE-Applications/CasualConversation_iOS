//
//  SettingViewModel.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/14.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common

import Foundation
import MessageUI

final class SettingViewModel: Dependency, ObservableObject {
	
	struct Dependency {
		
	}
	
	let dependency: Dependency
	
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
	}
	
}
