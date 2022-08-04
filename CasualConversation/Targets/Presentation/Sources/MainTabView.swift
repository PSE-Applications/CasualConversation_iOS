//
//  MainTabView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

public struct MainTabView: View {
	
	private enum Tab {
		case record, list, noteSet, settings
	}
	
	@EnvironmentObject private var sceneDIContainer: PresentationDIContainer
	@ObservedObject private var viewModel: MainTabViewModel
	@State private var selectedTab: Tab = .record
	
	public init(viewModel: MainTabViewModel) {
		self.viewModel = viewModel
	}

	public var body: some View {
		TabView(selection: $selectedTab) {
			Group {
				record
				list
				noteSet
				settings
			}
			.font(.system(size: 17, weight: .light))
		}
    }
    
}

extension MainTabView {
	
	var record: some View {
		sceneDIContainer.RecordView()
			.tag(Tab.record)
			.tabItem { Label("Record", systemImage: "record.circle") }
	}
	var list: some View {
		sceneDIContainer.ConversationListView()
			.tag(Tab.list)
			.tabItem { Label("Conversations", systemImage: "list.bullet.circle") }
	}
	var noteSet: some View {
		sceneDIContainer.NoteSetView()
			.tag(Tab.noteSet)
			.tabItem { Label("Notes", systemImage: "checklist") }
	}
	var settings: some View {
		Text("Settings View")
			.tag(Tab.settings)
			.tabItem { Label("Settings", systemImage: "gear.circle.fill")
			}
	}
	
}

#if DEBUG
struct MainTabView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer {
		.preview
	}
	
	static var previews: some View {
		container.MainTabView()
			.environmentObject(container)
	}
}
#endif
