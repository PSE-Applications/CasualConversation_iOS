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
	
	@Published var isRecording: Bool
	
	init(dependency: Dependency) {
		self.dependency = dependency
		
		self.isRecording = dependency.audioRecordService.status == .recording
	}
	
}

extension RecordViewModel {
	
	var buttonColorByisEditing: Color {
		isRecording ? .logoLightBlue : .logoDarkBlue
	}
	
}
