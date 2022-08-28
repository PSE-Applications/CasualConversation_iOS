//
//  RecordViewModel.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common
import Domain

import SwiftUI
import Foundation

final class RecordViewModel: Dependency, ObservableObject {
	
	struct Dependency {
		let useCase: ConversationRecodable
		let audioRecordService: CCRecorder
		
		public init(
			useCase: ConversationRecodable,
			audioRecordService: CCRecorder
		) {
			self.useCase = useCase
			self.audioRecordService = audioRecordService
		}
	}
	
	let dependency: Dependency
	var pins: [TimeInterval]?
	
	@Published var isStartedRecording: Bool
	@Published var inputTitle: String = ""
	
	init(dependency: Dependency) {
		self.dependency = dependency
		
		self.isStartedRecording = dependency.audioRecordService
			.status != .stopped // TODO: published 관련 고민하기
		
		setupRecording()
		print("\(Self.self) init") // TODO: Testable Code, Have to remove
	}
	
	deinit {
		removeRecording()
		print("\(Self.self) deinit") // TODO: Testable Code, Have to remove
	}
	
	private func setupRecording() {
		// TODO: CancelRecording - AudioRecordService
		print("\(Self.self) \(#function)") // TODO: Testable Code, Have to remove
	}
	
	private func removeRecording() {
		// TODO: CancelRecording - AudioRecordService
		print("\(Self.self) \(#function)") // TODO: Testable Code, Have to remove
		self.pins = nil
	}
	
	private func createItem(filePath: URL) {
		print("\(Self.self) \(#function)") // TODO: Testable Code, Have to remove
		let recordedDate: Date = .init()
		let title: String = inputTitle.isEmpty ? recordedDate.formattedString : inputTitle
		
		let newItem: Conversation = .init(
			id: .init(),
			title: title,
			members: [],
			recordFilePath: filePath,
			recordedDate: recordedDate,
			pins: self.pins ?? []
		)
		
		self.dependency.useCase.add(newItem) { error in
			guard error == nil else {
				print(error?.localizedDescription ?? "\(#function)")
				return
			}
			
			print("-----> createItem filePath\(filePath)") // TODO: Testable Code, Have to remove
		}
	}
	
}

extension RecordViewModel {
	
	var buttonColorByisEditing: Color {
		isStartedRecording ? .logoLightBlue : .logoDarkBlue
	}
	
}

extension RecordViewModel {
	
	func cancelRecording() {
		// TODO: CancelRecording - AudioRecordService
		print("\(Self.self) \(#function)") // TODO: Testable Code, Have to remove
	}
	
	func startRecording() {
		// TODO: StartRecording - AudioRecordService
		print("\(Self.self) \(#function)") // TODO: Testable Code, Have to remove
		self.pins = []
	}
	
	func pauseRecording() {
		// TODO: PauseRecording - AudioRecordService
		print("\(Self.self) \(#function)") // TODO: Testable Code, Have to remove
	}
	
	func stopRecording() {
		// TODO: StopRecording - AudioRecordService
		print("\(Self.self) \(#function)") // TODO: Testable Code, Have to remove
		let receivedFilePath: URL = .init(fileURLWithPath: "") // Test
		createItem(filePath: receivedFilePath)
	}
	
	func putOnPin() {
		// TODO: PauseRecording - AudioRecordService
		print("\(Self.self) \(#function)") // TODO: Testable Code, Have to remove
		guard let currentTime = self.dependency.audioRecordService.currentRecordingTime else {
			print("CurrentTime 불러오기 실패") // TODO: Error Handling
			return
		}
		self.pins?.append(currentTime)
	}
	
}
