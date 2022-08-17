//
//  SettingViewModel.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/14.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common

import Foundation

final class SettingViewModel: Dependency, ObservableObject {
	
	struct Dependency {
		
	}
	
	let dependency: Dependency
	
	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
}
