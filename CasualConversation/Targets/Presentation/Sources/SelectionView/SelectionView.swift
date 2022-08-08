//
//  SelectionView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

struct SelectionView: View {
	
	let viewModel: SelectionViewModel

	var body: some View {
		Text("Selection View")
	}
	
}

#if DEBUG
struct SelectionView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer {
		.preview
	}
	
	static var previews: some View {
		container.SelectionView(selected: .empty)
	}

}
#endif
