//
//  ConversationListView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/04.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

struct ConversationListView: View {
	
	let viewModel: ConversationListViewModel
	@EnvironmentObject private var container: PresentationDIContainer
	
	var body: some View {
		List {
			ForEach(viewModel.list, id: \.id) { item in
				NavigationLink(destination: container.SelectionView(selected: item)) {
					ConversationListRow(item: item)
				}
			}
			.onDelete(perform: removeRows)
		}
		.listStyle(.plain)
		.navigationTitle("Casual Conversation")
		.navigationBarTitleDisplayMode(.inline)
	}
	
}

extension ConversationListView {
	
	private func removeRows(at offsets: IndexSet) {
		for offset in offsets {
			self.viewModel.remove(at: offset)
		}
	}
	
}

#if DEBUG

struct ConversationListView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer { .preview }
	
	static var previews: some View {
		container.ConversationListView()
			.environmentObject(container)
	}

}

#endif
