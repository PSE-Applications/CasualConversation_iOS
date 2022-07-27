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
		let audioService: AudioService
		
		public init(
			useCase: ConversationRecodable,
			audioService: AudioService
		) {
			self.useCase = useCase
			self.audioService = audioService
		}
	}
	
	public let dependency: Dependency
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}
	
}
