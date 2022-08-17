//
//  RecordViewModel.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common
import Domain

import Combine

public final class RecordViewModel: Dependency, ObservableObject {
	
	public struct Dependency {
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
	
	public let dependency: Dependency
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}
	
}
