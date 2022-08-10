//
//  ConversationListRow.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/08/08.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Domain

import SwiftUI


struct ConversationListRow: View {
	
	let item: Conversation
	
	var body: some View {
		HStack {
			Image(systemName: "recordingtape")
				.foregroundColor(.logoLightRed)
			VStack(alignment: .leading) {
				Text(item.title ?? "")
					.font(.title3)
					.fontWeight(.bold)
					.lineLimit(1)
					.truncationMode(.tail)
				HStack(alignment: .center) {
					Text(item.topic ?? "")
						.font(.body)
						.lineLimit(1)
						.truncationMode(.tail)
					Spacer()
					VStack(alignment: .trailing) {
						Text(item.members.joined(separator: ", "))
							.font(.caption)
							.foregroundColor(.logoDarkGreen)
							.lineLimit(1)
							.truncationMode(.tail)
						Text(item.recordedDate.formattedString)
							.font(.caption2)
							.foregroundColor(.gray)
					}
				}
			}
			Spacer()
			if Bool.random() { // TODO: 처리방법 구상필요
				Image(systemName: "checkmark.circle.fill")
					.foregroundColor(.logoLightBlue)
			} else {
				Image(systemName: "circle")
					.foregroundColor(.logoDarkBlue)
			}
		}
	}
	
}

struct ConversationListRow_Previews: PreviewProvider {
		
	static let item: Conversation = .init(
		id: UUID(),
		title: "Preview Title",
		topic: "Preview Topic",
		members: ["Member 1", "Member 2", "Member 3"],
		recordFilePath: URL(fileURLWithPath: "Preview Path"),
		recordedDate: Date(),
		pins: []
	)
    
	static var previews: some View {
		ConversationListRow(item: item)
		.previewLayout(.sizeThatFits)
	}
	
}
