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
			.navigationBarTitleDisplayMode(.inline)
			.padding()
			.toolbar {
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
	
	private func NavigationSaveButton() -> some View {
		Button {
			viewModel.updateChanges()
			presentationMode.wrappedValue.dismiss()
		} label: {
			Text("저장")
				.font(.headline)
				.foregroundColor(.logoDarkGreen)
		}
		.disabled(!viewModel.isEdited)
		.opacity(viewModel.isEdited ? 1 : 0.3)
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
			Spacer()
		}
	}
	
	private func InputTextField(
		title: String,
		iconName: String,
		text: Binding<String>
	) -> some View {
		Group {
			Text(title)
				.font(.headline)
			HStack {
				Image(systemName: iconName)
					.foregroundColor(.logoLightBlue)
				TextField(title,
						  text: text,
						  prompt: Text(title.components(separatedBy: " ")[0]))
					.textFieldStyle(.roundedBorder)
					.onChange(of: text.wrappedValue) { value in
						viewModel.isEdited = true
					}
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
				.onChange(of: viewModel.original) { value in
					viewModel.isEdited = true
				}
				.background(
					Color.ccBgColor
						.cornerRadius(15)
				)
			HStack {
				Image(systemName: "k.circle.fill")
					.foregroundColor(.logoLightBlue)
				Text("번역 Translation")
			}
			TextEditor(text: $viewModel.translation)
				.onChange(of: viewModel.translation) { value in
					viewModel.isEdited = true
				}
				.background(
					Color.ccBgColor
						.cornerRadius(15)
				)
		}
	}
	
}

#if DEBUG
extension NoteDetailViewModel {
	
	static var previewViewModels: [NoteDetailViewModel] {
		[
			.init(dependency: .init(
				useCase: DebugNoteUseCase(),
				item: .init(
						id: .init(),
						original: "Way out",
						translation: "나가는 길",
						category: .vocabulary,
						references: [],
						createdDate: Date()
					)
				)
			),
			.init(dependency: .init(
				useCase: DebugNoteUseCase(),
				item: .init(
						id: .init(),
						original: "Hi, I'm Marco.\nI'm glad meet you.\nI'd like to talk to you.",
						translation: "안녕하세요, 저는 마르코입니다.\n만나서 반갑습니다.\n이야기하기를 바랬어요.",
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
struct NoteDetail_Previews: PreviewProvider {
	
	static let viewModels = NoteDetailViewModel.previewViewModels
	
	static var previews: some View {
		Group {
			NoteDetailView(viewModel: viewModels[0])
			NoteDetailView(viewModel: viewModels[1])
		}
		.previewLayout(.sizeThatFits)
		.preferredColorScheme(.light)
		Group {
			NoteDetailView(viewModel: viewModels[0])
			NoteDetailView(viewModel: viewModels[1])
		}
		.previewLayout(.sizeThatFits)
		.preferredColorScheme(.dark)
	}
}
#endif
