//
//  Conversation.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/25.
//

import Foundation
import Common

public struct Conversation: UUIDIdentifiable {
        
	public let id: Identifier
    var title: String?
    var topic: String?
    let members: [Member]
    let recordFilePath: URL
    let recordedDate: Date
    
}
