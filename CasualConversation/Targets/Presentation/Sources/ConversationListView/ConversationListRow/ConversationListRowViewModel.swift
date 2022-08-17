//
//  ConversationListRowViewModel.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/13.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

import SwiftUI

final class ConversationListRowViewModel: Dependency, ObservableObject {
	
	struct Dependency {
		let item: Conversation
	}
	
	let dependency: Dependency
	
	@Published var title: String
	@Published var topic: String
	@Published var members: String
	@Published var recordedDate: String
	@Published var isChecked: Bool
	
	init(dependency: Dependency) {
		self.dependency = dependency
		
		self.title = dependency.item.title ?? ""
		self.topic = dependency.item.topic ?? ""
		self.members = dependency.item.members.joined(separator: ", ")
		self.recordedDate = dependency.item.recordedDate.formattedString
		self.isChecked = Bool.random() // TODO: 처리방법 구상필요
	}
	
}

#if DEBUG

extension ConversationListRowViewModel {
	
	static let previewViewModel: ConversationListRowViewModel = .init(
		dependency: .init(
			item: .init(
				id: UUID(),
				title: "Preview Title",
				topic: "Preview Topic",
				members: ["Member 1", "Member 2", "Member 3"],
				recordFilePath: URL(fileURLWithPath: "Preview Path"),
				recordedDate: Date(),
				pins: []
			)
		)
	)
	
}

#endif
