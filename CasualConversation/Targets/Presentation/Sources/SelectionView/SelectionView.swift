//
//  SelectionView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Domain

import SwiftUI

struct SelectionView: View {
	
	enum Tab: Int, CaseIterable, Hashable {
		case every
	}
	
	let viewModel: SelectionViewModel
	let item: Conversation
	@EnvironmentObject private var container: PresentationDIContainer
	
	@State private var isEditing: Bool = false
	
	@State private var title: String = ""
	@State private var topic: String = ""
	@State private var members: String = "" // TODO: 저장 시 (콤마, 공백) 제거처리
	
	@State private var inputText: String = ""
	@State private var isVocabulary: Bool = true
	@State private var isOriginal: Bool = true
	
	init(viewModel: SelectionViewModel, item: Conversation) {
		self.viewModel = viewModel
		self.item = item
	}

	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				VStack {
					HTitleTextField(
						title: "제목", prompt: Text("제목을 입력하세요"),
						text: $title, isEditing: $isEditing
					)
					HTitleTextField(
						title: "주제", prompt: Text("주제를 선택하세요"),
						text: $topic, isEditing: $isEditing
					)
					HTitleTextField(
						title: "참여", prompt: Text("참여인원을 추가하세요"),
						text: $members, isEditing: $isEditing
					)
				}
			}
			Divider()
			InputView
				.padding()
			Divider()
			container.NoteSetView(by: viewModel.referenceNoteUseCase)
			Spacer()
			PlayTabView
		}
		.onAppear(perform: setupData)
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
						  text: $inputText,
						  prompt: Text(
							"\(isOriginal ? "영어" : "한글") \(isVocabulary ? "문장" : "단어") 입력하세요"
						  )
				)
				.textFieldStyle(.roundedBorder)
				Button {
					// TODO: Note 추가 동작 구현
				} label: {
					Image(systemName: "plus")
				}
			}
		}
	}
	
	var PlayTabView: some View { // TODO: 재생 기능  UI 구성 및 구현 필요
		VStack(alignment: .center) {
			Rectangle()
				.frame(height: 44)
			HStack(alignment: .center) {
				Button {
					
				} label: {
					Spacer()
					Text("x1.0")
						.font(.system(size: 24))
						.fontWeight(.bold)
					Spacer()
				}
				Button {
					
				} label: {
					Spacer()
					Circle()
						.frame(height: 70, alignment: .top)
					Spacer()
				}
				Button {
					
				} label: {
					Spacer()
					Circle()
						.frame(height: 70, alignment: .top)
					Spacer()
				}
			}
		}
		.background(Color(.systemGroupedBackground))
	}
}

extension SelectionView {
	
	private func setupData() {
		self.title = item.title ?? ""
		self.topic = item.topic ?? ""
		self.members = item.members.joined(separator: ", ")
	}
	
	private func HTitleTextField(title: String, prompt: Text, text: Binding<String>, isEditing: Binding<Bool>) -> some View {
		HStack {
			HStack {
				Text(title)
					.font(.body)
					.fontWeight(.bold)
				TextField(title, text: text, prompt: prompt)
					.textFieldStyle(.roundedBorder)
					.disabled(!isEditing.wrappedValue)
					.shadow(color: isEditing.wrappedValue ? .logoLightBlue : .gray, radius: 1, x: 2, y: 2)
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
