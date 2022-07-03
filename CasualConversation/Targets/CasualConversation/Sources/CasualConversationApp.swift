//
//  CasualConversationApp.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common
import Domain
import Data
import Presentation

import SwiftUI

@main
struct CasualConversationApp: App {
	
	private let presentationDIContainer: PresentationDIContainer = AppDIContainer().makeSceneDIContainer()
	
    var body: some Scene {
        WindowGroup {
			presentationDIContainer.MainTabView()
				.environmentObject(presentationDIContainer)
        }
    }
    
}
