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
		if viewModel.isDone {
			VStack(alignment: .leading) {
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

#if DEBUG
extension NoteSetRowViewModel {
	
	static var previewViewModels: [NoteSetRowViewModel] {
		[
			.init(dependency: .init(
				item: .init(
						id: .init(),
						original: "Hello",
						translation: "안녕",
						category: .vocabulary,
						references: [],
						createdDate: Date()
					)
				)
			),
			.init(dependency: .init(
				item: .init(
						id: .init(),
						original: "Nice to meet you.",
						translation: "",
						category: .sentence,
						references: [],
						createdDate: Date()
					)
				)
			),
			.init(dependency: .init(
				item: .init(
						id: .init(),
						original: "",
						translation: "한국말 문장만 있는 노트",
						category: .sentence,
						references: [],
						createdDate: Date()
					)
				)
			)
		]
	}
	
}

// MARK: - Preview
struct NoteSetRow_Previews: PreviewProvider {
	
	static let viewModels = NoteSetRowViewModel.previewViewModels
	
    static var previews: some View {
		Group {
			NoteSetRow(viewModel: viewModels[0])
			NoteSetRow(viewModel: viewModels[1])
		}
		.previewLayout(.sizeThatFits)
		.preferredColorScheme(.light)
		Group {
			NoteSetRow(viewModel: viewModels[0])
			NoteSetRow(viewModel: viewModels[2])
		}
		.previewLayout(.sizeThatFits)
		.preferredColorScheme(.dark)
		
	}
	
}
#endif
