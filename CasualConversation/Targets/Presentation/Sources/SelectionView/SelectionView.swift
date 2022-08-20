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
	
	@State var isEditing: Bool = false {
		willSet {
			viewModel.setEmptyTitleToDefault(by: newValue)
		}
	}
	@FocusState var focusedField: Field?
	
	var body: some View {
		VStack(alignment: .leading) {
			EditableInfoSection()
			NoteInput()
			SelectedNoteSet()
			Spacer()
			PlayTabView()
		}
		.toolbar {
			ToolbarItem(placement: .navigation) {
				EditableNavigationTitle()
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
						if !viewModel.addNote() {
							addAlert.toggle()
						}
					}, label: {
						Text("추가")
					}
				)
			}
		}
		.alert("추가 실패", isPresented: $addAlert) {
			Button("확인", role: .cancel) { }
		} message: {
			Text("올바른 조건으로 입력해주세요")
		}
		.onAppear {
			UITextField.appearance().backgroundColor = UIColor
				.init(colorScheme == .dark ? Color.recordShadow : Color.white)
		}
	}
	
}

extension SelectionView {
	
	@ViewBuilder
	private func EditableNavigationTitle() -> some View {
		HStack {
			if isEditing {
				HStack {
					TextField("Title",
							  text: $viewModel.title,
							  prompt: Text(viewModel.recordedDate)
					)
					.textFieldStyle(.roundedBorder)
					.shadow(
						color: viewModel.isEditingShadowColor(by: isEditing),
						radius: 1, x: 1, y: 1
					)
					.focused($focusedField, equals: .infoTitle)
					Spacer()
				}
			} else {
				Text(viewModel.title)
					.font(.headline)
			}
		}
	}
	
	@ViewBuilder
	private func EditableInfoSection() -> some View {
		if focusedField != .inputNote {
			GroupBox {
				Button(
					action: {
						withAnimation {
							isEditing.toggle()
						}
					}, label: {
						HStack {
							Text("Information")
								.font(.headline)
							Spacer()
							if isEditing {
								Text("완료")
							}
							Image(systemName: "chevron.right")
								.foregroundColor(.logoDarkGreen)
								.rotationEffect(.degrees(isEditing ? 90.0 : 0.0))
						}
					}
				)
				if isEditing {
					EditableInfos()
				}
			}
			.padding([.leading, .trailing])
		}
	}
	
	@ViewBuilder
	private func EditableInfos() -> some View {
		VStack {
			HStack {
				Text("주제")
					.font(.body)
					.fontWeight(.bold)
				TextField("Topic",
						  text: $viewModel.topic,
						  prompt: Text("주제를 선택하세요")
				)
				.textFieldStyle(.roundedBorder)
				.shadow(
					color: viewModel.isEditingShadowColor(by: isEditing),
					radius: 1, x: 1, y: 1
				)
			}
			.focused($focusedField, equals: .infoTopic)
			HStack {
				Text("참여")
					.font(.body)
					.fontWeight(.bold)
				TextField("Member",
						  text: $viewModel.members,
						  prompt: Text("참여인원을 추가하세요")
				)
				.textFieldStyle(.roundedBorder)
				.shadow(
					color: viewModel.isEditingShadowColor(by: isEditing),
					radius: 1, x: 1, y: 1
				)
			}
			.focused($focusedField, equals: .infoMember)
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
						if !viewModel.addNote() {
							addAlert.toggle()
						}
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
