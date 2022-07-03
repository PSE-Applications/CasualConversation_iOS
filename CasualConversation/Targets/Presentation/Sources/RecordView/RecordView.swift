//
//  RecordView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

public struct RecordView: View {
	
	private let viewModel: RecordViewModel
	
	public init(viewModel: RecordViewModel) {
		self.viewModel = viewModel
	}

	public var body: some View {
		Text("Hello world")
	}
	
}

struct RecordView_Previews: PreviewProvider {
	
	static var previews: some View {
		RecordView()
	}
	
}
