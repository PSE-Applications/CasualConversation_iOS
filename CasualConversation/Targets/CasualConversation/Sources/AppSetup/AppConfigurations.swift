//
//  AppConfigurations.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common

import Foundation
import AVFAudio

final class AppConfigurations {
	
	private let pageList: NSDictionary
	
	init() {
		guard let filePath = Bundle.main.path(forResource: "URLs", ofType: "plist"),
			  let plist = NSDictionary(contentsOfFile: filePath) else {
			fatalError("URLs.plist 불러오기 실패")
		}
		self.pageList = plist
		
		// MARK: - AVAudioSession setCategory
		let session = AVAudioSession.sharedInstance()
		do {
			try session.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
			try session.setActive(true)
		} catch {
			CCError.log.append(.log("\(Self.self) \(#function) - setCategory Failure"))
		}
	}
	
	// MARK: Presentation Layer
	lazy var mainURL = self.pageList.object(forKey: "Main") as! String
	lazy var cafeURL = self.pageList.object(forKey: "Cafe") as! String
	lazy var eLearningURL = self.pageList.object(forKey: "eLearning") as! String
	lazy var tasteURL = mainURL + (self.pageList.object(forKey: "TastePage") as! String)
	lazy var testURL = mainURL + (self.pageList.object(forKey: "TestPage") as! String)
	lazy var receptionTel = self.pageList.object(forKey: "ReceptionPhoneNumber") as! String
	
}
