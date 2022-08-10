//
//  NoteSetView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Domain

import SwiftUI

struct NoteSetView: View {
	
	let viewModel: NoteSetViewModel
	@State private var isPresentedNoteDetail = false
	@State private var selectedRowItem: Note?
	
	var body: some View {
		VStack {
			List {
				ForEach(viewModel.list, id: \.id) { item in
					NoteSetRow(item: item)
						.onTapGesture {
							selectedRowItem = item
							isPresentedNoteDetail.toggle()
						}
				}
				.onDelete(perform: removeRow)
			}
			.listStyle(.plain)
		}
		.sheet(item: $selectedRowItem) { item in
			NoteDetail(item: item)
		}
	}
	
}

extension NoteSetView {
	
	private func removeRow(at indexSet: IndexSet) {
		print(#function)
	}
	
}

#if DEBUG
struct NoteSetView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer { .preview }
	
	static var previews: some View {
		container.NoteSetView()
			.environmentObject(container)
	}

}
#endif
