//
//  NoteDetail.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/08.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

// TODO: UI 구성 디벨롭 필요
struct NoteDetailView: View {
	
	@Environment(\.presentationMode) private var presentationMode

	@ObservedObject var viewModel: NoteDetailViewModel
	
	var body: some View {
		NavigationView {
			VStack(alignment: .leading) {
				NoteContent(by: viewModel.isVocabulary)
			}
			.padding()
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					NavigationCancelButton()
				}
				ToolbarItem(placement: .principal) {
					NavigationTitleLabel()
				}
				ToolbarItem(placement: .navigationBarTrailing) {
					NavigationSaveButton()
				}
			}
		}
	}
	
}

extension NoteDetailView {
	
	@ViewBuilder
	private func NavigationTitleLabel() -> some View {
		HStack {
			Image(systemName: viewModel.navigationTitleIconImageName)
				.foregroundColor(.logoLightRed)
			Text(viewModel.navigationTitle)
				.font(.headline)
		}
	}
	
	private func NavigationCancelButton() -> some View {
		Button {
			presentationMode.wrappedValue.dismiss()
		} label: {
			Text("취소")
				.font(.headline)
				.foregroundColor(.logoDarkGreen)
		}
	}
	
	private func NavigationSaveButton() -> some View {
		Button {
			// Update
			presentationMode.wrappedValue.dismiss()
		} label: {
			Text("완료")
				.font(.headline)
				.foregroundColor(.logoDarkGreen)
		}
	}
	
	@ViewBuilder
	private func NoteContent(by condition: Bool) -> some View {
		if condition {
			Vocabulary()
		} else {
			Sentense()
		}
	}
	
	private func Vocabulary() -> some View {
		VStack(alignment: .leading) {
			Spacer()
			InputTextField(
				title: "단어 Original",
				iconName: "e.circle.fill",
				text: $viewModel.original
			)
			InputTextField(
				title: "번역 Translation",
				iconName: "k.circle.fill",
				text: $viewModel.translation
			)
			InputTextField(
				title: "발음 Pronunciation",
				iconName: "person.wave.2.fill",
				text: $viewModel.pronunciation
			)
			Spacer()
		}
	}
	
	private func InputTextField(title: String, iconName: String, text: Binding<String>) -> some View {
		Group {
			Text(title)
				.font(.headline)
			HStack {
				Image(systemName: iconName)
					.foregroundColor(.logoLightBlue)
				TextField(title, text: $viewModel.original, prompt: Text(title.components(separatedBy: " ")[0]))
					.textFieldStyle(.roundedBorder)
					.shadow(color: .gray, radius: 1, x: 2, y: 2)
			}
		}
	}
	
	private func Sentense() -> some View {
		VStack(alignment: .leading) {
			HStack {
				Image(systemName: "e.circle.fill")
					.foregroundColor(.logoLightBlue)
				Text("문장 Original")
			}
			TextEditor(text: $viewModel.original)
			HStack {
				Image(systemName: "k.circle.fill")
					.foregroundColor(.logoLightBlue)
				Text("번역 Translation")
			}
			TextEditor(text: $viewModel.translation)
		}
	}
	
}

#if DEBUG
import Common
import Domain

struct DebugNoteUseCase: NoteManagable {
	func list() -> [Note] {
		NoteDetail_Previews.dummyList
	}
	
	func add(item: Note, completion: (CCError?) -> Void) {
		
	}
	
	func edit(newItem: Note, completion: (CCError?) -> Void) {
		
	}
	
	func delete(item: Note, completion: (CCError?) -> Void) {
	}

}

#endif

struct NoteDetail_Previews: PreviewProvider {
	
	static let dummyList: [Note] = [
		.init(
			id: .init(),
			original: "Way out",
			translation: "나가는 길",
			category: .vocabulary,
			references: [],
			createdDate: Date()
		),
		.init(
			id: .init(),
			original: "Hi, I'm Marco.\nI'm glad meet you.\nI'd like to talk to you.",
			translation: "안녕하세요, 저는 마르코입니다.\n만나서 반갑습니다.\n이야기하기를 바랬어요.",
			category: .sentece,
			references: [],
			createdDate: Date()
		)
	]
	
	static let useCase: DebugNoteUseCase = .init()
	
	static var previews: some View {
		NoteDetailView(viewModel: .init(dependency:
				.init(
					useCase: useCase,
					item: dummyList[0]
				)
			)
		)
		.previewLayout(.sizeThatFits)
		NoteDetailView(viewModel: .init(dependency:
				.init(
					useCase: useCase,
					item: dummyList[1]
				)
			)
		)
		.previewLayout(.sizeThatFits)
	}
}
