//
//  NoteSetView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Domain

import SwiftUI

struct NoteSetView: View {
	
	@EnvironmentObject private var container: PresentationDIContainer
	@ObservedObject var viewModel: NoteSetViewModel
	
	@State private var isPresentedNoteDetail: Bool = false
	@State private var selectedRowItem: Note?
	
	var body: some View {
		VStack {
			List {
				ForEach(viewModel.list, id: \.id) { item in
					container.NoteSetRow(by: item)
						.listRowBackground(Color.clear)
						.contentShape(Rectangle())
						.onTapGesture {
							selectedRowItem = item
							isPresentedNoteDetail.toggle()
						}
				}
				.onDelete(perform: viewModel.removeRows)
			}
			.listStyle(.plain)
		}
		.sheet(item: $selectedRowItem) { item in
			HalfSheet(isFlexible: item.category == .sentence) {
				container.NoteDetailView(selected: item)
			}
		}
	}
	
}

#if DEBUG // MARK: - Preview
struct NoteSetView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer { .preview }
	
	static var previews: some View {
		container.NoteSetView()
			.environmentObject(container)
			.preferredColorScheme(.light)
		container.NoteSetView()
			.environmentObject(container)
			.preferredColorScheme(.dark)
	}

}
#endif
