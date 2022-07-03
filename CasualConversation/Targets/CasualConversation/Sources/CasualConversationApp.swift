//
//  CasualConversationApp.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

import Domain
import DataLayer

@main
struct CasualConversationApp: App {
    
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainTabView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
}
