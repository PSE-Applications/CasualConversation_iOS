//
//  Conversation.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/25.
//

import Foundation

struct Conversation: Identifiable {
    
    typealias Identifier = UUID
    
    let id: Identifier
    let title: String
    let topic: String
    let members: [String]
    let recordFilePath: String
    let date: Data
    
}
