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
		let audioService: AudioRecordable
	}
	
	let dependency: Dependency
	
	@Published var isRecording: Bool
	
	init(dependency: Dependency) {
		self.dependency = dependency
		
		self.isRecording = dependency.audioService.status == .recording
	}
	
}

extension RecordViewModel {
	
	var buttonColorByisEditing: Color {
		isRecording ? .logoLightBlue : .logoDarkBlue
	}
	
}
