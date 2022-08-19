//
//  ConversationListView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/04.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

struct ConversationListView: View {
	
	@EnvironmentObject private var container: PresentationDIContainer
	@ObservedObject var viewModel: ConversationListViewModel
	
	var body: some View {
		List {
			ForEach(viewModel.list, id: \.id) { item in
				NavigationLink(destination: container.SelectionView(selected: item)) {
					container.ConversationListRow(selected: item)
				}
			}
			.onDelete(perform: viewModel.removeRows)
		}
		.listStyle(.plain)
	}
	
}

// MARK: - Preview
struct ConversationListView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer { .preview }
	
	static var previews: some View {
		container.ConversationListView()
			.environmentObject(container)
	}

}
