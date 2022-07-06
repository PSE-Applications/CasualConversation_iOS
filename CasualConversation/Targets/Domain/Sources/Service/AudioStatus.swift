//
//  AudioStatus.swift
//  Domain
//
//  Created by Yongwoo Marco on 2022/07/06.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Foundation

enum AudioStatus: Int, CustomStringConvertible {
	
	case stopped
	case playing
	case recording
	
	var audioName: String {
		let audioNames = ["Audio:Stopped", "Audio:Playing", "Audio:Recording"]
		return audioNames[rawValue]
	}
	
	var description: String {
		return audioName
	}
}
