//
//  NoteSetView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

public struct NoteSetView: View {
	
	private let viewModel: NoteSetViewModel
	
	public init(viewModel: NoteSetViewModel) {
		self.viewModel = viewModel
	}

	public var body: some View {
		Text("NoteSet View")
	}
	
}

#if DEBUG
struct NoteSetView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer {
		.preview
	}
	
	static var previews: some View {
		container.NoteSetView()
	}

}
#endif
