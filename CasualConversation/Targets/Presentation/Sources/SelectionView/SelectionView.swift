//
//  SelectionView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

struct SelectionView: View {
	
	@EnvironmentObject private var container: PresentationDIContainer
	@ObservedObject var viewModel: SelectionViewModel
	
	@State var isEditing: Bool = false
	
	var body: some View {
		VStack(alignment: .leading) {
			EditableInfos()
			Divider()
			NoteInput()
			Divider()
			SelectedNoteSet()
			Spacer()
			PlayTabView()
		}
		.padding()
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				EditToolbarToggle()
			}
		}
	}
	
}

extension SelectionView {
	
	private func EditToolbarToggle() -> some View {
		Toggle(isOn: $isEditing) {
			Text(viewModel.editToggleLabel(by: isEditing))
		}
		.toggleStyle(.button)
	}
	
	private func EditableInfos() -> some View {
		VStack {
			InfoTextField(
				label: "제목",
				prompt: "제목을 입력하세요",
				text: $viewModel.title
			)
			InfoTextField(
				label: "주제",
				prompt: "주제를 선택하세요",
				text: $viewModel.topic
			)
			InfoTextField(
				label: "참여",
				prompt: "참여인원을 추가하세요",
				text: $viewModel.members
			)
		}
	}
	
	private func InfoTextField(
		label: String,
		prompt: String,
		text: Binding<String>
	) -> some View {
		return HStack {
			HStack {
				Text(label)
					.font(.body)
					.fontWeight(.bold)
				TextField(label, text: text, prompt: Text(prompt))
					.textFieldStyle(.roundedBorder)
					.disabled(!isEditing)
					.shadow(
						color: viewModel.isEditingShadowColor(by: isEditing),
						radius: 1, x: 2, y: 2
					)
			}
		}
	}
	
	private func NoteInput() -> some View {
		VStack(spacing: 8) {
			HStack {
				Toggle(isOn: $viewModel.isOriginal) {
					Label {
						Text(viewModel.isOriginalSwitchLabel)
					} icon: {
						Image(systemName: viewModel.isOriginalSwitchImageName
						)
					}
				}
				.tint(.logoDarkGreen)
				Toggle(isOn: $viewModel.isVocabulary) {
					Label {
						Text(viewModel.isVocabularySwitchLabel)
					} icon: {
						Image(systemName: viewModel.isVocabularySwitchImageName
						)
					}
				}
				.tint(.logoLightGreen)
				Spacer()
			}
			.toggleStyle(.button)
			HStack {
				TextField("Input Text",
						  text: $viewModel.inputText,
						  prompt: Text(viewModel.inputTextFieldPrompt)
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
	
	private func SelectedNoteSet() -> some View {
		container.NoteSetView(by: viewModel.referenceNoteUseCase)
	}
	
	private func PlayTabView() -> some View {
		container.PlayTabView()
	}
	
}

// MARK: - Preview
struct SelectionView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer { .preview }
	
	static var previews: some View {
		container.SelectionView(selected: .empty)
			.environmentObject(container)
	}

}
