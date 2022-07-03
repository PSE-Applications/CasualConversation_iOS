//
//  SelectionView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

public struct SelectionView: View {
	
	private let viewModel: SelectionViewModel
	
	public init(viewModel: SelectionViewModel) {
		self.viewModel = viewModel
	}

	public var body: some View {
		Text("Hello world")
	}
	
}

//struct SelectionView_Previews: PreviewProvider {
//
//	static var previews: some View {
//		SelectionView()
//	}
//
//}
