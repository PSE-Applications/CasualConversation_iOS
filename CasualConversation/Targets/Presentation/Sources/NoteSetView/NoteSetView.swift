//
//  NoteSetView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

struct NoteSetView: View {
	
	let viewModel: NoteSetViewModel
	
	var body: some View {
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
