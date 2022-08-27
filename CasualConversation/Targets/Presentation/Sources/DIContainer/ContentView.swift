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
	
	public init() {
		AppAppearance.setup()
	}
	
	public var body: some View {
		container.MainTabView()
			.environmentObject(container.configurations)
    }
	
}

// MARK: - Preview

#if DEBUG
import Common
import Domain
import Data

import AVFAudio
import Foundation
import Combine

// MARK: Data Layer
struct DebugRecordRepository: RecordDataControllerProtocol {
	
	func makeAudioRecorder() -> AudioRecorderProtocol? {
		let recordSettings: [String: Any] = [
			AVFormatIDKey: Int(kAudioFormatLinearPCM),
			AVSampleRateKey: 44100.0,
			AVNumberOfChannelsKey: 1,
			AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
		]
		let currentDate = Date().formatted(.dateTime)
		let newFilePath = FileManager.default.temporaryDirectory.appendingPathComponent(currentDate.description)
		let recorder = try? AVAudioRecorder(url: newFilePath, settings: recordSettings)
		return recorder
	}
	
	func makeAudioPlayer(from filePath: URL) -> AudioPlayerProtocol? {
		guard let player = try? AVAudioPlayer(contentsOf: filePath) else {
			return nil
		}
		return player
	}
	
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
	
	func fetch() -> [Conversation]? {
		dummyModel
	}
	
	func create(_ item: Conversation, completion: (CCError?) -> Void) {
		print(#function)
	}
	
	func update(after updatedItem: Conversation, completion: (CCError?) -> Void) {
		print(#function)
	}
	
	func delete(_ item: Conversation, completion: (CCError?) -> Void) {
		print(#function)
	}
	
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
			return dummyModel.enumerated().filter { $0.offset % 2 == Int.random(in: 0...1) }.map { $0.element }
		} else {
			return dummyModel
		}
	}
	
	func create(_ item: Note, completion: (CCError?) -> Void) {
		print(#function)
	}
	
	func update(after updatedItem: Note, completion: (CCError?) -> Void) {
		print(#function)
	}
	
	func delete(_ item: Note, completion: (CCError?) -> Void) {
		print(#function)
	}
	
}

// MARK: Domain Layer
final class DebugNoteUseCase: NoteManagable {
	
	@Published private var list: [Note] = []
	var dataSourcePublisher: Published<[Note]>.Publisher { $list }
	
	func add(item: Note, completion: (CCError?) -> Void) {
		
	}
	
	func edit(_ newItem: Note, completion: (CCError?) -> Void) {
		
	}
	
	func delete(item: Note, completion: (CCError?) -> Void) {
		
	}

}

// MARK: Presentation Layer
extension PresentationDIContainer {
	
	static var preview: PresentationDIContainer {
		.init(dependency: .init(
			configurations: PresentationConfiguarations.preview,
			conversationRepository: DebugConversationRepository(),
			noteRepository: DebugNoteRepository(),
			recordRepository: DebugRecordRepository())
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

#endif

struct ContentView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer { .preview }
	
    static var previews: some View {
        ContentView()
			.environmentObject(container)
    }
}
