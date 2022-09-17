//
//  SelectionView.swift
//  Presentation
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
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
	@EnvironmentObject private var container: PresentationDIContainer
	@ObservedObject var viewModel: SelectionViewModel
	
	@State private var isEditing: Bool = false {
		willSet { viewModel.updateEditing(by: newValue) }
	}
	@State private var addAlert: Bool = false
	@FocusState private var focusedField: Field?
	
	var body: some View {
		VStack {
			EditableInfoSection()
			NoteInput()
			SelectedNoteSet()
		}
		.overlay {
			PlayTabView()
		}
		.background(Color.ccBgColor)
		.navigationBarBackButtonHidden(true)
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Button(
					action: {
						self.mode.wrappedValue.dismiss()
						if isEditing {
							viewModel.updateEditing(by: false)
						}
					}, label: {
						HStack {
							Image(systemName: "chevron.backward")
							Text("Back")
						}
					}
				)
			}
			ToolbarItem(placement: .navigationBarTrailing) {
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
						if viewModel.isAbleToAdd {
							viewModel.addNote()
						} else {
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
	}
	
}

extension SelectionView {
	
	@ViewBuilder
	private func EditableNavigationTitle() -> some View {
		if isEditing {
			HStack {
				TextField("Title",
						  text: $viewModel.title,
						  prompt: Text(viewModel.recordedDate)
				)
				.multilineTextAlignment(.trailing)
				.textFieldStyle(.roundedBorder)
				.focused($focusedField, equals: .infoTitle)
			}
		} else {
			Text(viewModel.title)
				.font(.headline)
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
							Text("Conversation Information")
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
						  prompt: Text("주제를 입력하세요")
				)
				.textFieldStyle(.roundedBorder)
			}
			.focused($focusedField, equals: .infoTopic)
			HStack {
				Text("참여")
					.font(.body)
					.fontWeight(.bold)
				TextField("Member",
						  text: $viewModel.members,
						  prompt: Text("참여인원을 추가하세요 (공백 분리)")
				)
				.textFieldStyle(.roundedBorder)
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
						if viewModel.isAbleToAdd {
							viewModel.addNote()
						} else {
							addAlert.toggle()
						}
					} label: {
						Image(systemName: "plus")
							.font(.headline)
					}
				}
			}
		}
		.padding([.leading, .trailing])
	}
	
	private func SelectedNoteSet() -> some View {
		container.NoteSetView(by: viewModel.referenceNoteUseCase)
	}
	
	private func PlayTabView() -> some View {
		VStack {
			Spacer()
			container.PlayTabView(with: viewModel.referenceItem)
		}
	}
	
}

#if DEBUG // MARK: - Preview
struct SelectionView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer { .preview }
	
	static var previews: some View {
		container.SelectionView(selected: .empty)
			.environmentObject(container)
			.preferredColorScheme(.light)
		container.SelectionView(selected: .empty)
			.environmentObject(container)
			.preferredColorScheme(.dark)
	}

}
#endif
