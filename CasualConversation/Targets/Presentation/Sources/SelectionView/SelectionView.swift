//
//  SelectionView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

struct SelectionView: View {
	
	enum Field {
		case infoTitle
		case infoTopic
		case infoMember
		case inputNote
	}
	
	@Environment(\.colorScheme) var colorScheme
	
	@EnvironmentObject private var container: PresentationDIContainer
	@ObservedObject var viewModel: SelectionViewModel
	
	@State var isEditing: Bool = false
	@FocusState var focusedField: Field?
	
	var body: some View {
		VStack(alignment: .leading) {
			EditableInfos()
			NoteInput()
			SelectedNoteSet()
			Spacer()
			PlayTabView()
		}
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				EditToolbarToggle()
			}
			ToolbarItemGroup(placement: .keyboard) {
				Button(
					action: {
						dismissKeyboard()
					}, label: {
						Image(systemName: "keyboard.chevron.compact.down")
					}
				)
				Spacer()
				Button(
					action: {
						// TODO: Note 추가 동작 구현
					}, label: {
						Text("추가")
					}
				)
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
	
	@ViewBuilder
	private func EditableInfos() -> some View {
		if focusedField != .inputNote {
			GroupBox {
				VStack {
					InfoTextField(
						label: "제목",
						prompt: "제목을 입력하세요",
						text: $viewModel.title
					)
					.focused($focusedField, equals: .infoTitle)
					InfoTextField(
						label: "주제",
						prompt: "주제를 선택하세요",
						text: $viewModel.topic
					)
					.focused($focusedField, equals: .infoTopic)
					InfoTextField(
						label: "참여",
						prompt: "참여인원을 추가하세요",
						text: $viewModel.members
					)
					.focused($focusedField, equals: .infoMember)
				}
			}
			.padding([.leading, .trailing])
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
		GroupBox {
			VStack(spacing: 8) {
				HStack {
					Picker("Language", selection: $viewModel.language) {
						ForEach(SelectionViewModel.Language.allCases, id: \.self) { condition in
							Text(condition.description)
								.tag(condition)
						}
					}
					.pickerStyle(.segmented)
					Spacer()
					Picker("Category", selection: $viewModel.category) {
						ForEach(SelectionViewModel.Category.allCases, id: \.self) { condition in
							Text(condition.description)
								.tag(condition)
						}
					}
					.pickerStyle(.segmented)
				}
				.toggleStyle(.button)
				HStack {
					TextField("Input Text",
							  text: $viewModel.inputText,
							  prompt: Text(viewModel.inputTextFieldPrompt)
					)
					.textFieldStyle(.roundedBorder)
					.showClearButton($viewModel.inputText)
					.focused($focusedField, equals: .inputNote)
					Button {
						// TODO: Note 추가 동작 구현
					} label: {
						Image(systemName: "plus.circle.fill")
					}
				}
			}
		}
		.padding([.leading, .trailing])
		.onAppear {
			UISegmentedControl.appearance().selectedSegmentTintColor = UIColor
				.init(self.colorScheme == .dark ? .logoDarkGreen : .logoLightGreen)
		}
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
