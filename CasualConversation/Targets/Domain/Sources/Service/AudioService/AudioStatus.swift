//
//  AudioStatus.swift
//  Domain
//
//  Created by Yongwoo Marco on 2022/07/06.
//  Copyright © 2022 pseapplications. All rights reserved.
//


public enum AudioStatus: Int, CustomStringConvertible {
	
	case stopped
	case playing
	case recording
	case paused
	
	var audioName: String {
		let audioNames = ["Audio:Stopped",
						  "Audio:Playing",
						  "Audio:Recording",
						  "Audio:Paused"]
		return audioNames[rawValue]
	}
	
	public var description: String {
		return audioName
	}
	
}
