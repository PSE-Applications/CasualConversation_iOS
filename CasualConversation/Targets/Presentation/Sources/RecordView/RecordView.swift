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
		Text("Record View")
	}
	
}

#if DEBUG
struct RecordView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer {
		.preview
	}
	
	static var previews: some View {
		container.RecordView()
	}

}
#endif
