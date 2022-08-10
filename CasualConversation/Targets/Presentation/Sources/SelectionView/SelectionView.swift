//
//  SelectionView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Domain

import SwiftUI

struct SelectionView: View {
	
	@EnvironmentObject private var container: PresentationDIContainer
	@ObservedObject var viewModel: SelectionViewModel
	
	@State private var isEditing: Bool = false
	@State private var isVocabulary: Bool = true
	@State private var isOriginal: Bool = true
	 
	var body: some View {
		VStack(alignment: .leading) {
			InfoView
			Divider()
			InputView
			Divider()
			IncludeNoteSet
			Spacer()
			IncludePlayTabView
		}
		.padding()
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Toggle(isOn: $isEditing) {
					Text(isEditing ? "완료" : "수정")
					EditButton()
				}
				.toggleStyle(.button)
			}
		}
	}
	
	var InfoView: some View {
		VStack {
			InfoTextField(label: "제목", prompt: "제목을 입력하세요", text: $viewModel.title)
			InfoTextField(label: "주제", prompt: "주제를 선택하세요", text: $viewModel.topic)
			InfoTextField(label: "참여", prompt: "참여인원을 추가하세요", text: $viewModel.members)
		}
	}
	
	var InputView: some View {
		VStack(spacing: 8) {
			HStack {
				Toggle(isOn: $isOriginal) {
					Label {
						Text(isOriginal ? "영어" : "한글")
					} icon: {
						Image(systemName: isOriginal ? "e.circle.fill" : "k.circle.fill")
					}
					
				}
				.toggleStyle(.button)
				.tint(.logoDarkGreen)
				Toggle(isOn: $isVocabulary) {
					Label {
						Text(isVocabulary ? "문장" : "단어")
					} icon: {
						Image(systemName: isVocabulary ? "text.bubble.fill" : "textformat.abc")
					}
				}
				.toggleStyle(.button)
				.tint(.logoLightGreen)
				Spacer()
			}
			HStack {
				TextField("Input Text",
						  text: $viewModel.inputText,
						  prompt: Text("\(isOriginal ? "영어" : "한글") \(isVocabulary ? "문장" : "단어") 입력하세요")
				)
				.textFieldStyle(.roundedBorder)
				Button {
					// TODO: Note 추가 동작 구현
				} label: {
					Image(systemName: "plus")
				}
			}
		}
		.padding()
	}
	
	var IncludeNoteSet: some View {
		container.NoteSetView(by: viewModel.referenceNoteUseCase)
	}
	
	var IncludePlayTabView: some View {
		container.PlayTabView()
	}
}

extension SelectionView {
	
	private func InfoTextField(
		label: String,
		prompt: String,
		text: Binding<String>
	) -> some View {
		var isEditingShadowColor: Color { isEditing ? .logoLightBlue : .gray }
		return HStack {
			HStack {
				Text(label)
					.font(.body)
					.fontWeight(.bold)
				TextField(label, text: text, prompt: Text(prompt))
					.textFieldStyle(.roundedBorder)
					.disabled(!isEditing)
					.shadow(color: isEditingShadowColor, radius: 1, x: 2, y: 2)
			}
		}
	}
	
}

#if DEBUG
struct SelectionView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer { .preview }
	
	static var previews: some View {
		container.SelectionView(selected: .empty)
			.environmentObject(container)
	}

}
#endif
