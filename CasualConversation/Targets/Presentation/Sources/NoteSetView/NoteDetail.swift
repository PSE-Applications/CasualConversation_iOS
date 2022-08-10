//
//  NoteDetail.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/08.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Domain

import SwiftUI

// TODO: UI 구성 디벨롭 필요
struct NoteDetail: View {
	
	let item: Note
	
	@Environment(\.presentationMode) private var presentationMode
	
	@State private var original: String = ""
	@State private var translation: String = ""
	@State private var pronunciation: String = ""
	@State private var isVocabulary: Bool = true
	
	var body: some View {
		VStack(alignment: .leading) {
			HStack(alignment: .center) {
				Button {
					presentationMode.wrappedValue.dismiss()
				} label: {
					Text("취소")
				}
				.foregroundColor(.logoDarkGreen)

				Spacer()
				Image(systemName: isVocabulary ? "textformat.abc" : "text.bubble.fill")
					.foregroundColor(.logoLightRed)
				Text(isVocabulary ? "Vocabulary" : "Sentense")
					.font(.headline)
				Spacer()
				Button {
					// Update
					presentationMode.wrappedValue.dismiss()
				} label: {
					Text("완료")
				}
				.foregroundColor(.logoDarkGreen)

			}
			Divider()
			if isVocabulary {
				Vocabulary
			} else {
				Sentense
			}
		}
		.padding()
		.onAppear(perform: setupData)
		.navigationTitle(isVocabulary ? "Vocabulary" : "Sentence")
	}
	
	var Vocabulary: some View {
		Group {
			Spacer()
			Text("단어 Original")
				.font(.headline)
			HStack {
				Image(systemName: "e.circle.fill")
					.foregroundColor(.logoLightBlue)
				TextField("단어", text: $original, prompt: Text("단어를 입력하세요"))
					.textFieldStyle(.roundedBorder)
					.shadow(color: .gray, radius: 1, x: 2, y: 2)
			}

			Text("번역 Translation")
				.font(.headline)
			HStack {
				Image(systemName: "k.circle.fill")
					.foregroundColor(.logoLightBlue)
				TextField("번역", text: $translation, prompt: Text("번역을 입력하세요"))
					.textFieldStyle(.roundedBorder)
					.shadow(color: .gray, radius: 1, x: 2, y: 2)
			}

			Text("발음 Pronunciation")
				.font(.headline)
			HStack {
				Image(systemName: "person.wave.2.fill")
					.foregroundColor(.logoLightBlue)
				TextField("발음", text: $pronunciation, prompt: Text("발음을 입력하세요"))
					.textFieldStyle(.roundedBorder)
					.shadow(color: .gray, radius: 1, x: 2, y: 2)
			}
			Spacer()
		}
	}
	
	var Sentense: some View {
		Group {
			Spacer()
			HStack {
				Image(systemName: "e.circle.fill")
					.foregroundColor(.logoLightBlue)
				Text("문장 Original")
			}
			TextEditor(text: $original)
			HStack {
				Image(systemName: "k.circle.fill")
					.foregroundColor(.logoLightBlue)
				Text("번역 Translation")
			}
			TextEditor(text: $translation)
			Spacer()
		}
	}
	
}

extension NoteDetail {
	
	private func setupData() {
		self.original = item.original
		self.translation = item.translation
		self.isVocabulary = (item.category == .vocabulary)
	}
	
}

#if DEBUG

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
	
	static var previews: some View {
		NoteDetail(item: dummyList[0])
		NoteDetail(item: dummyList[1])
	}
}

#endif
