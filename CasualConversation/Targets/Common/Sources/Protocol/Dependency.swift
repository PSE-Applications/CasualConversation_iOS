//
//  Dependency.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

public protocol Dependency {
	associatedtype Dependency
	
	var dependency: Dependency { get }
	
	init(dependency: Dependency)
}
