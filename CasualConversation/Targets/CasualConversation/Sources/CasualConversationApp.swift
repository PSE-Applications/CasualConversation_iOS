//
//  CasualConversationApp.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

@main
struct CasualConversationApp: App {
	
	private let appDIContainer = AppDIContainer()
	
    var body: some Scene {
        WindowGroup {
			appDIContainer.ContentView()
				.environmentObject(appDIContainer.makePresentationDIContainer())
				.onAppear {
					Thread.sleep(forTimeInterval: 2.0)
				}
        }
    }
    
}
