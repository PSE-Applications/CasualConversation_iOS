//
//  CasualConversationApp.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

import Domain
import DataLayer

import Swinject
import SwinjectAutoregistration


@main
struct CasualConversationApp: App {
    
//    let persistenceController = PersistenceController.shared
	private let container: Container = {
		let container = Container()
		
		// MainTabView
		container.register(MainTabView.self) { resolve in
//			let viewModel = resolve.resolve(MainTabViewModel.self)
			return MainTabView()
		}
		
		// RecordView
		
		// SelectionView
		
		// NoteSetView
		
		return container
	}()

    var body: some Scene {
        WindowGroup {
            MainTabView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
}
