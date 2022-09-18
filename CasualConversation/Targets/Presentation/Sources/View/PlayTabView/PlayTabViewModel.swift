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
import Combine

final class PlayTabViewModel: Dependency, ObservableObject {
		
	enum Speed: Float, CaseIterable, CustomStringConvertible {
		case half = 0.5
		case threeQuater = 0.75
		case `default` = 1.0
		case oneAndOneQuater = 1.25
		case oneAndHalf = 1.5
		case oneAndThreeQuater = 1.75
		case double = 2.0
		
		var description: String {
			switch self {
			case .half, .default, .oneAndHalf, .double:
				return String(format: "%.1fx", self.rawValue)
			default:
				return String(format: "%.2fx", self.rawValue)
			}
		}
	}
	
	enum Direction {
		case forward
		case back
		case next
	}
	
	struct Dependency {
		let item: Conversation
		let audioService: CCPlayer
	}
	
	let dependency: Dependency
	
	@Published var speed: Speed = .default {
		didSet { self.changedPlayingSpeed() }
	}
	@Published var nextPin: TimeInterval?
	@Published var isPlaying: Bool = false
	@Published var currentTime: TimeInterval = .zero
	@Published var duration: TimeInterval = .zero
	@Published var skipSecond: Double = Preference.shared.skipTime.rawValue
	
	private var cancellableSet = Set<AnyCancellable>()
	
	init(dependency: Dependency) {
		self.dependency = dependency
		
		dependency.audioService.isPlayingPublisher
			.assign(to: &self.$isPlaying)
		dependency.audioService.currentTimePublisher
			.sink(receiveValue: { [weak self] currentTime in
				self?.currentTime = currentTime
				self?.changedCurrentTime()
			})
			.store(in: &cancellableSet)
		dependency.audioService.durationPublisher
			.assign(to: &self.$duration)
	}
	
	deinit {
		
	}
	
	private func changedPlayingSpeed() {
		self.dependency.audioService.changePlayingRate(to: speed.rawValue)
	}
	
	private func changedCurrentTime() {
		self.nextPin = dependency.item.pins.first(where: { currentTime < $0 })
	}
	
}

extension PlayTabViewModel {
	
	var disabledPlaying: Bool {
		duration == .zero
	}
	var disabledPlayingOpacity: Double {
		disabledPlaying ? 0.3 : 1.0
	}
	var skipTime: String {
		"\(Int(skipSecond))"
	}
	var isPlayingImageName: String {
		if disabledPlaying {
			return "speaker.slash.circle.fill"
		} else {
			return self.isPlaying ? "pause.circle.fill" : "play.circle.fill"
		}
	}
	var nextPinButtonOpacity: Double {
		self.nextPin != nil ? 1 : 0.3
	}
	
}

extension PlayTabViewModel {
	
	func setupPlaying() {
		let filePath = dependency.item.recordFilePath
		self.dependency.audioService.setupPlaying(filePath: filePath) { error in
			guard error == nil else {
				return
			}
		}
	}
	
	func startPlaying() {
		self.dependency.audioService.startPlaying()
	}
	
	func pausePlaying() {
		self.dependency.audioService.pausePlaying()
	}
	
	func skip(_ direction: Direction) {
		let timeToSeek: Double
		switch direction {
		case .forward:
			timeToSeek = currentTime + skipSecond
		case .back:
			timeToSeek = currentTime - skipSecond
		case .next:
			guard let nextTimeToSeek = nextPin else {
				return
			}
			timeToSeek = nextTimeToSeek
		}
		self.currentTime = timeToSeek
		self.dependency.audioService.seek(to: timeToSeek)
	}
	
	func editingSliderPointer() {
		self.dependency.audioService.stopTrackingCurrentTime()
	}
	
	func editedSliderPointer() {
		self.dependency.audioService.seek(to: currentTime)
	}
	
	func finishPlaying() {
		self.dependency.audioService.finishPlaying()
	}
	
}

