//
//  NoteSetRow.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/08.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Domain

import SwiftUI

struct NoteSetRow: View {
	
	let item: Note
	
	var body: some View {
		HStack {
			Image(systemName: item.category == .sentece ? "text.bubble.fill" : "textformat.abc")
				.foregroundColor(.logoLightRed)
				.frame(width: 36, alignment: .center)
			VStack {
				if item.original.isEmpty {
					Text(item.translation)
				} else if item.translation.isEmpty {
					Text(item.original)
				} else {
					Text(item.original)
					Text(item.translation)
						.font(.caption)
						.foregroundColor(.gray)
				}
			}
			Spacer()
			if item.original.isEmpty {
				Image(systemName: "k.circle")
					.foregroundColor(.logoDarkBlue)
			} else if item.translation.isEmpty {
				Image(systemName: "e.circle")
					.foregroundColor(.logoDarkBlue)
			} else {
				Image(systemName: "checkmark.circle.fill")
					.foregroundColor(.logoLightBlue)
			}
		}
		.font(.body)
	}
	
}

#if DEBUG

struct NoteSetRow_Previews: PreviewProvider {
	
	static func dummyItem(category: Note.Category) -> Note {
		switch category {
		case .vocabulary:
			return .init(
				id: .init(),
				original: "Hello",
				translation: "안녕",
				category: category,
				references: [],
				createdDate: Date()
			)
		case .sentece:
			return .init(
				id: .init(),
				original: "Nice to meet you.",
				translation: "",
				category: category,
				references: [],
				createdDate: Date()
			)
		}
	}
	
    static var previews: some View {
		NoteSetRow(item: dummyItem(category: .vocabulary))
			.previewLayout(.sizeThatFits)
		NoteSetRow(item: dummyItem(category: .sentece))
			.previewLayout(.sizeThatFits)
	}
	
}

#endif
