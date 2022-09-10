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
	var pins: Set<TimeInterval> = []
	
	@Published var isPermitted: Bool = false {
		willSet {
			if newValue {
				startRecording()
			} else if !isPermitted {
				// TODO: Alert 구현필요
			}
		}
	}
	@Published var isRecording: Bool = false
	@Published var isPrepared: Bool = false
	@Published var inputTitle: String = Date().formattedString
	@Published var inputTopic: String = ""
	@Published var inputMember: String = ""
	@Published var members: [Member] = []
	
	@Published var currentTime: TimeInterval = .zero {
		didSet { print(currentTime) }
	}
	@Published var recordingTime: TimeInterval = .zero
	
	private var progressTimer: Timer?
	
	init(dependency: Dependency) {
		self.dependency = dependency
		
		dependency.audioService.isRecordingPublisher
			.assign(to: &self.$isRecording)
	}
	
	deinit {

	}
	
	private func createItem(filePath: URL) {
		let recordedDate: Date = .init()
		let title: String = inputTitle.isEmpty ? recordedDate.formattedString : inputTitle
		
		let newItem: Conversation = .init(
			id: .init(),
			title: title,
			members: self.members.map({ $0.name }),
			recordFilePath: filePath,
			recordedDate: recordedDate,
			pins: self.pins.sorted(by: <)
		)
		
		self.dependency.useCase.add(newItem) { error in
			guard error == nil else {
				print(error?.localizedDescription ?? "\(#function)")
				return
			}
			// TODO: Testable Code, Have to remove
			print("-----> createItem filePath")
			print("\(filePath)")
		}
	}
	
	private func randomEmoji() -> String {
		let emoji = "😀😃😄😁😆🥹😂🤣😊☺️🙂😉😌😍😘🥰🥳😙😚😋😛😝🤓😎🥸🤩🤭🤗🤠"
			.map({ String($0) }).randomElement()!
		return emoji
	}
	
}

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
	
}

extension RecordViewModel {
	
	func recordPermission() {
		self.dependency.audioService.permission { [weak self] response in
			self?.isPermitted = response
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
	
	func setupRecording() {
		self.dependency.audioService.setupRecorder { error in
			guard error == nil else {
				print(String(describing: error?.localizedDescription))
				return
			}
			isPrepared = true
			pins = []
			members = []
		}
	}
	
	func cancelRecording() {
		self.dependency.audioService.removeRecording(isCancel: true)
	}
	
	func startRecording() {
		self.dependency.audioService.startRecording()
		progressTimer = Timer.scheduledTimer(
			timeInterval: 0.1,
			target: self,
			selector: #selector(updateRealTimeValues),
			userInfo: nil,
			repeats: true
		)
	}
	
	@objc func updateRealTimeValues() {
		self.currentTime = dependency.audioService.currentTime
	}
	
	func pauseRecording() {
		self.dependency.audioService.pauseRecording()
		self.progressTimer?.invalidate()
	}
	
	func stopRecording() {
		self.dependency.audioService.stopRecording { result in
			switch result {
			case .success(let filePath):
				createItem(filePath: filePath)
			case .failure(let error):
				print(error)
			}
			dependency.audioService.removeRecording(isCancel: false)
		}
	}
	
	func finishRecording() {
		self.progressTimer?.invalidate()
		self.isPrepared = false
		self.members = []
		self.pins = []
	}
	
	func putOnPin() {
		guard currentTime > 0 else {
			return
		}
		self.pins.update(with: currentTime)
	}
	
}
