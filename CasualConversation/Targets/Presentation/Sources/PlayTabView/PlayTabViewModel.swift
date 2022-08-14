//
//  PlayTabViewModel.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/10.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

import SwiftUI

final class PlayTabViewModel: Dependency, ObservableObject {
	
	enum Speed: String, CaseIterable {
		case half = "0.5"
		case `default` = "1.0"
		case oneAndOneQuater = "1.25"
		case oneAndHalf = "1.5"
		case oneAndThreeQuater = "1.75"
		case double = "2.0"
	}
	
	struct Dependency {
		let audioService: AudioPlayable
	}
	
	let dependency: Dependency
	
	@Published var speed: Speed = .default
	
	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
}

extension PlayTabViewModel {
	
	func isPlayingImageName(by condition: Bool) -> String {
		condition ? "pause.circle.fill" : "play.circle.fill"
	}
	
	func nextPinButtonOpacity(by condition: Bool) -> Double {
		condition ? 1 : 0.3
	}
	
}

extension PlayTabViewModel {
	
	var currentTime: TimeInterval {
		self.dependency.audioService.currentPlayingTime ?? 0
	}
	
	var duration: TimeInterval {
		self.dependency.audioService.playDuration ?? 0
	}
	
}
