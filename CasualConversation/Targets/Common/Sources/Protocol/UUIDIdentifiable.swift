//
//  UUIDIdentifier.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import Foundation

public protocol UUIDIdentifiable: Identifiable {
	
	typealias Identifier = UUID
	
}
