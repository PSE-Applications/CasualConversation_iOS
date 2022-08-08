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
	
	var body: some View {
		List {
}

extension ConversationListView {
	
	}
	
}

#if DEBUG
struct ConversationListView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer {
		.preview
	}
	
	static var previews: some View {
		container.ConversationListView()
	}

}
#endif
