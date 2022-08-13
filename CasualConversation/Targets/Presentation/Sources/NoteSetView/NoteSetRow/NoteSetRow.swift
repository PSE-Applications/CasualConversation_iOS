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
			CategoryImage()
			NoteContent()
		}
		.font(.body)
	}
	
}

extension NoteSetRow {
	
	private func CategoryImage() -> some View {
		Image(systemName: viewModel.categoryImageName)
			.foregroundColor(.logoLightRed)
			.frame(width: 36, alignment: .center)
	}
	
	@ViewBuilder
	private func NoteContent() -> some View {
		if !viewModel.original.isEmpty, !viewModel.translation.isEmpty {
			VStack {
				Text(viewModel.original)
				Text(viewModel.translation)
					.font(.caption)
					.foregroundColor(.gray)
			}
			Spacer()
			Image(systemName: "checkmark.circle.fill")
				.foregroundColor(.logoLightBlue)
		} else {
			VStack {
				Text(viewModel.noteContentLabel)
			}
			Spacer()
			Image(systemName: viewModel.noteContentImageName)
				.foregroundColor(.logoDarkBlue)
		}
	}
	
}

struct NoteSetRow_Previews: PreviewProvider {
	
	static let viewModels = NoteSetRowViewModel.previewViewModels
	
    static var previews: some View {
		NoteSetRow(viewModel: viewModels[0])
			.previewLayout(.sizeThatFits)
		NoteSetRow(viewModel: viewModels[1])
			.previewLayout(.sizeThatFits)
		NoteSetRow(viewModel: viewModels[2])
			.previewLayout(.sizeThatFits)
	}
	
}
