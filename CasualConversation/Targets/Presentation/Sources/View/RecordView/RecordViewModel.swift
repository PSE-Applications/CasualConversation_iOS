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
		let audioService: CCRecorder
		
		public init(
			useCase: ConversationRecodable,
			audioService: CCRecorder
		) {
			self.useCase = useCase
			self.audioService = audioService
		}
	}
	
	struct Member: Hashable {
		let name: String
		let emoji: String
	}
	
	let dependency: Dependency
	
	@Published var isPermitted: Bool = false
	@Published var isRecording: Bool = false
	@Published var isPrepared: Bool = false
	@Published var inputTitle: String = Date().formattedString
	@Published var inputTopic: String = ""
	@Published var inputMember: String = ""
	@Published var members: [Member] = []
	@Published var pins: [TimeInterval] = []
	
	@Published var currentTime: TimeInterval = .zero
	@Published var recordingTime: TimeInterval = .zero
	
	init(dependency: Dependency) {
		self.dependency = dependency
		
		dependency.audioService.isRecordingPublisher
			.assign(to: &self.$isRecording)
		dependency.audioService.currentTimePublisher
			.assign(to: &self.$currentTime)
	}
	
	deinit {

	}
	
	private func createItem(filePath: URL) {
		let recordedDate: Date = .init()
		let title: String = inputTitle.isEmpty ? recordedDate.formattedString : inputTitle
		
		let newItem: Conversation = .init(
			id: .init(),
			title: title,
			topic: inputTopic,
			members: members.map({ $0.name }),
			recordFilePath: filePath,
			recordedDate: recordedDate,
			pins: pins
		)
		
		self.dependency.useCase.add(newItem) { error in
			guard error == nil else {
				CCError.log.append(error!)
				return
			}
			// TODO: Testable Code, Have to remove
			print("-----> createItem filePath \n\(filePath)")
		}
	}
	
	private func randomEmoji() -> String {
		let emoji = "😀😃😄😁😆🥹😂🤣😊☺️🙂😉😌😍😘🥰🥳😙😚😋😛😝🤓😎🥸🤩🤭🤗🤠"
			.map({ String($0) }).randomElement()!
		return emoji
	}
	
}

// MARK: - UI Configure
extension RecordViewModel {
	
	var stopButtonTintColor: Color {
		canSaveRecording ? .logoLightBlue : .logoDarkBlue
	}
	var pinButtonTintColor: Color {
		isRecording ? .logoLightBlue : .logoDarkBlue
	}
	var canSaveRecording: Bool {
		currentTime > 0 ? true : false
	}
	var currentTimeTintColor: Color {
		isRecording ? .white : .gray
	}
	var onRecordingTintColor: Color {
		isRecording ? .logoLightRed : .logoDarkRed
	}
	var onRecordingOpacity: Double {
		if isRecording {
			return Int(currentTime) % 2 == 0 ? 1.0 : 0.0
		} else {
			return 1.0
		}
	}
	
}

// MARK: - Methods
extension RecordViewModel {
	
	// MARK: Member
	func recordPermission() {
		self.dependency.audioService.permission { [weak self] response in
			DispatchQueue.main.async {
				self?.isPermitted = response
			}
		}
	}
	
	func addMember() {
		let trimmedString = inputMember.trimmingCharacters(in: [" "])
		guard trimmedString.count > 0 else {
			return
		}
		let randomEmoji = randomEmoji()
		self.members.insert(.init(name: trimmedString, emoji: randomEmoji), at: 0)
		self.inputMember = ""
	}
	
	func remove(member: Member) {
		guard let index = members.firstIndex(of: member) else {
			return
		}
		self.members.remove(at: index)
	}
	
	// MARK: Pin
	func putOnPin() {
		guard currentTime > 0,
			  pins.filter(
				{ Int($0) % 60 == Int(currentTime) % 60 }
			  ).count == 0
		else {
			return
		}
		self.pins.append(currentTime)
	}
	
	func remove(pin time: TimeInterval) {
		guard let index = pins.firstIndex(of: time) else {
			return
		}
		self.pins.remove(at: index)
	}
	
	// MARK: Recording
	func setupRecording() {
		self.dependency.audioService.setupRecorder { error in
			guard error == nil else {
				CCError.log.append(error!)
				return
			}
			isPrepared = true
			pins = []
			members = []
		}
	}
	
	func cancelRecording() {
		self.dependency.audioService.finishRecording(isCancel: true)
	}
	
	func startRecording() {
		self.dependency.audioService.startRecording()
	}
	
	func pauseRecording() {
		self.dependency.audioService.pauseRecording()
	}
	
	func stopRecording() {
		self.dependency.audioService.stopRecording { result in
			switch result {
			case .success(let filePath):
				createItem(filePath: filePath)
			case .failure(let error):
				CCError.log.append(error)
			}
			dependency.audioService.finishRecording(isCancel: false)
		}
	}
	
	func finishRecording() {
		self.isPrepared = false
		self.members = []
		self.pins = []
	}
	
}
