//
//  NoteSetRow.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/08.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

struct NoteSetRow: View {
	
	@ObservedObject var viewModel: NoteSetRowViewModel
	
	var body: some View {
		HStack {
			CategoryImage(by: viewModel.category == .sentece)
			NoteContent()
		}
		.font(.body)
	}
	
}

extension NoteSetRow {
	
	private func CategoryImage(by condition: Bool) -> some View {
		Image(systemName: condition ? "text.bubble.fill" : "textformat.abc")
			.foregroundColor(.logoLightRed)
			.frame(width: 36, alignment: .center)
	}
	
	@ViewBuilder
	private func NoteContent() -> some View {
		if viewModel.original.isEmpty {
			VStack {
				Text(viewModel.translation)
			}
			Spacer()
			Image(systemName: "k.circle")
				.foregroundColor(.logoDarkBlue)
		} else if viewModel.translation.isEmpty {
			VStack {
				Text(viewModel.original)
			}
			Spacer()
			Image(systemName: "e.circle")
				.foregroundColor(.logoDarkBlue)
		} else {
			VStack {
				Text(viewModel.original)
				Text(viewModel.translation)
					.font(.caption)
					.foregroundColor(.gray)
			}
			Spacer()
			Image(systemName: "checkmark.circle.fill")
				.foregroundColor(.logoLightBlue)
		}
	}
	
}

struct NoteSetRow_Previews: PreviewProvider {
	
	static let viewModels = NoteSetRowViewModel.debugViewModels
	
    static var previews: some View {
		NoteSetRow(viewModel: viewModels[0])
			.previewLayout(.sizeThatFits)
		NoteSetRow(viewModel: viewModels[1])
			.previewLayout(.sizeThatFits)
	}
	
}
