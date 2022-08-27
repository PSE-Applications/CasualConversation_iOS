//
//  PresentationConfiguaration.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/25.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Foundation

public class PresentationConfiguarations: ObservableObject, Dependency {
	
	public struct Dependency {
		public let mainURL: URL
		public let cafeURL: URL
		public let eLearningURL: URL
		public let tasteURL: URL
		public let testURL: URL
		public let receptionTel: URL
		
		public init(
			mainURL: URL,
			cafeURL: URL,
			eLearningURL: URL,
			tasteURL: URL,
			testURL: URL,
			receptionTel: URL
		) {
			self.mainURL = mainURL
			self.cafeURL = cafeURL
			self.eLearningURL = eLearningURL
			self.tasteURL = tasteURL
			self.testURL = testURL
			self.receptionTel = receptionTel
		}
	}
	
	public let dependency: Dependency
	
	public var mainURL: URL { self.dependency.mainURL }
	public var cafeURL: URL { self.dependency.cafeURL }
	public var eLearningURL: URL { self.dependency.eLearningURL }
	public var tasteURL: URL { self.dependency.tasteURL }
	public var testURL: URL { self.dependency.testURL }
	public var receptionTel: URL { self.dependency.receptionTel }
	
	required public init(dependency: Dependency) {
		self.dependency = dependency
	}
	
}
