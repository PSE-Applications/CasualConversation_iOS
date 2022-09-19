//
//  ContentView.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/08.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

public struct ContentView: View {
	
	@EnvironmentObject private var container: PresentationDIContainer
	@StateObject private var preference: Preference = .shared
	@State private var isPresentedTutorial: Bool = !Preference.shared.isDoneTutorial
	
	public init() {
		AppAppearance.setup()
	}
	
	public var body: some View {
		MainTabView()
			.environmentObject(container.configurations)
			.accentColor(.ccAccentColor)
			.preferredColorScheme(preference.colorScheme)
			.fullScreenCover(isPresented: $isPresentedTutorial) {
				TutorialView()
			}
    }
	
}

extension ContentView {
	
	private func MainTabView() -> some View {
		container.MainTabView()
	}
	
}

#if DEBUG
import Common
import Domain
import Data

// MARK: Data Layer
struct DebugRecordDataController: RecordDataControllerProtocol {
	
	func requestNewFilePath() -> URL {
		return URL(fileURLWithPath: "DEBUG")
	}
	func requestRecordData(from filePath: URL) -> Data? { return nil }
	func deleteRecordData(from filePath: URL, completion: (CCError?) -> Void) {	}
	
}

struct DebugConversationRepository: ConversationDataControllerProtocol {
	
	private var dummyModel: [Conversation] = [
		.init(
			id: .init(),
			title: Date().formattedString,
			members: [],
			recordFilePath: .init(fileURLWithPath: ""),
			recordedDate: Date(),
			pins: []
		),
		.init(
			id: .init(),
			title: "지하철 외국인",
			topic: "인사",
			members: ["나", "외국인"],
			recordFilePath: .init(fileURLWithPath: ""),
			recordedDate: Date(timeIntervalSinceNow: 100.0),
			pins: []),
		.init(
			id: .init(),
			title: "with Date",
			topic: "Weather",
			members: ["Me, Dale"],
			recordFilePath: .init(fileURLWithPath: ""),
			recordedDate: Date(timeIntervalSinceNow: 200.0),
			pins: []),
		.init(
			id: .init(),
			title: Date(timeIntervalSinceNow: 250).formattedString,
			members: [],
			recordFilePath: .init(fileURLWithPath: ""),
			recordedDate: Date(timeIntervalSinceNow: 250),
			pins: []
		)
	]
	
	func fetch() -> [Conversation]? { dummyModel }
	func create(_ item: Conversation, completion: (CCError?) -> Void) { }
	func update(after updatedItem: Conversation, completion: (CCError?) -> Void) { }
	func delete(_ item: Conversation, completion: (CCError?) -> Void) { }
	
}

struct DebugNoteRepository: NoteDataControllerProtocol {
	
	private var dummyModel: [Note] = [
		.init(
			id: .init(),
			original: "컴퓨터",
			translation: "",
			category: .vocabulary,
			references: [],
			createdDate: Date()),
		.init(
			id: .init(),
			original: "",
			translation: "Conversation",
			category: .vocabulary,
			references: [],
			createdDate: Date(timeIntervalSinceNow: 200)),
		.init(
			id: .init(),
			original: "This is a sentence",
			translation: "이거슨 문장입니다.",
			category: .sentence,
			references: [],
			createdDate: Date(timeIntervalSinceNow: 150)),
		.init(
			id: .init(),
			original: "",
			translation: "하고 싶었던 한국말 문장을 저장해 놈",
			category: .sentence,
			references: [],
			createdDate: Date()),
		.init(
			id: .init(),
			original: "Complete",
			translation: "완성하다",
			category: .vocabulary,
			references: [],
			createdDate: Date(timeIntervalSinceNow: 100)),
		.init(
			id: .init(),
			original: "These are sentences\nThey have sevaral lines.\nlike this",
			translation: "",
			category: .sentence,
			references: [],
			createdDate: Date(timeIntervalSinceNow: 50))
	]
	
	func fetch(filter item: Conversation?) -> [Note]? {
		if let _ = item {
			return dummyModel.enumerated()
				.filter { $0.offset % 2 == Int.random(in: 0...1) }.map { $0.element }
		} else {
			return dummyModel
		}
	}
	func create(_ item: Note, completion: (CCError?) -> Void) { }
	func update(after updatedItem: Note, completion: (CCError?) -> Void) { }
	func delete(_ item: Note, completion: (CCError?) -> Void) { }
	
}

// MARK: Domain Layer
final class DebugNoteUseCase: NoteManagable {
	
	@Published private var list: [Note] = []
	var dataSourcePublisher: Published<[Note]>.Publisher { $list }
	func add(item: Note, completion: (CCError?) -> Void) { }
	func edit(_ newItem: Note, completion: (CCError?) -> Void) { }
	func delete(item: Note, completion: (CCError?) -> Void) { }

}

// MARK: Presentation Layer
extension PresentationDIContainer {
	
	static var preview: PresentationDIContainer {
		.init(dependency: .init(
			configurations: PresentationConfiguarations.preview,
			conversationRepository: DebugConversationRepository(),
			noteRepository: DebugNoteRepository(),
			recordRepository: DebugRecordDataController())
		)
	}
	
}

extension PresentationConfiguarations {
	
	static var preview: Self {
		Self.init(dependency: .init(
			mainURL: URL(fileURLWithPath: ""),
			cafeURL: URL(fileURLWithPath: ""),
			eLearningURL: URL(fileURLWithPath: ""),
			tasteURL: URL(fileURLWithPath: ""),
			testURL: URL(fileURLWithPath: ""),
			receptionTel: URL(fileURLWithPath: ""))
		)
	}
	
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer { .preview }
	
    static var previews: some View {
        ContentView()
			.environmentObject(container)
    }
}
#endif
