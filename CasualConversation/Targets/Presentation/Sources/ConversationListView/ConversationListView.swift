//
//  ConversationListView.swift
//  Domain
//
//  Created by Yongwoo Marco on 2022/07/04.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

public struct ConversationListView: View {
	
	private let viewModel: ConversationListViewModel
	
	public init(viewModel: ConversationListViewModel) {
		self.viewModel = viewModel
	}

	public var body: some View {
		Text("Hello world")
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
