//
//  ConversationListRow.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/08/08.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

struct ConversationListRow: View {
	
	@ObservedObject var viewModel: ConversationListRowViewModel
	
	var body: some View {
		HStack {
			RowLeadingImage()
			RowContent()
			Spacer()
			CheckMarkIndicator()
		}
	}
	
}

extension ConversationListRow {
	
	private func RowLeadingImage() -> some View {
		Image(systemName: "recordingtape")
			.foregroundColor(.logoLightRed)
	}
	
	private func RowContent() -> some View {
		VStack(alignment: .leading) {
			Text(viewModel.title)
				.font(.title3)
				.fontWeight(.bold)
				.lineLimit(1)
				.truncationMode(.tail)
			HStack(alignment: .center) {
				Text(viewModel.topic)
					.font(.body)
					.lineLimit(1)
					.truncationMode(.tail)
				Spacer()
				VStack(alignment: .trailing) {
					Text(viewModel.members)
						.font(.caption)
						.foregroundColor(.logoDarkGreen)
						.lineLimit(1)
						.truncationMode(.tail)
					Text(viewModel.recordedDate)
						.font(.caption2)
						.foregroundColor(.gray)
				}
			}
		}
	}
	
	@ViewBuilder
	private func CheckMarkIndicator() -> some View {
		if viewModel.isChecked {
			Image(systemName: "info.circle.fill")
				.foregroundColor(.logoLightBlue)
		} else {
			Image(systemName: "circle")
				.foregroundColor(.logoDarkBlue)
		}
	}
	
}

#if DEBUG // MARK: - Preview
struct ConversationListRow_Previews: PreviewProvider {

	static let viewModel = ConversationListRowViewModel.previewViewModel
    
	static var previews: some View {
		ConversationListRow(viewModel: viewModel)
		.previewLayout(.sizeThatFits)
		.preferredColorScheme(.light)
		ConversationListRow(viewModel: viewModel)
		.previewLayout(.sizeThatFits)
		.preferredColorScheme(.dark)
	}
	
}
#endif
