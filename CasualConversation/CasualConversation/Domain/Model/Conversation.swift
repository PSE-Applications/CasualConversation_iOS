//
//  Conversation.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/25.
//

import Foundation

struct Conversation: UUIDIdentifiable {
        
    let id: Identifier
    var title: String?
    var topic: String?
    let members: [Member]
    let recordFilePath: String
    let recordedDate: Data
    
}
