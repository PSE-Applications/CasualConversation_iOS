//
//  MainTabView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

struct MainTabView: View {
	
	enum Tab {
		case conversations, notes
	}
	
	@EnvironmentObject private var container: PresentationDIContainer
	
	@State private var selectedIndex: Tab = .conversations
	@State private var isPresentedRecordView: Bool = false

	var body: some View {
		NavigationView {
			VStack {
				Spacer()
				MainContent(by: selectedIndex)
				Spacer()
				MainTabView()
			}
			.navigationTitle(selectedIndex == .conversations ? "Conversations" : "Notes")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					SettingToolbarLink()
				}
			}
			.fullScreenCover(isPresented: $isPresentedRecordView) {
				container.RecordView()
			}
		}
		.accentColor(.logoDarkGreen)
    }
	
	
	
}

extension MainTabView {
	
	private func SettingToolbarLink() -> some View {
		NavigationLink(destination: container.SettingView()) {
			Image(systemName: "gear")
		}
	}
	
	@ViewBuilder
	private func MainContent(by tab: Tab) -> some View {
		switch tab {
		case .conversations:
			container.ConversationListView()
		case .notes:
			container.NoteSetView()
		}
	}
	
	private func MainTabView() -> some View {
		HStack(alignment: .center) {
			CCTabItem(tab: .conversations)
			Button(
				action: {
					isPresentedRecordView.toggle()
				}, label: {
					Spacer()
					ZStack(alignment: .center) {
						Circle()
							.fill(Color.logoLightGreen)
							.frame(height: 74)
						Image(systemName: "mic.fill.badge.plus")
							.font(.system(size: 44))
							.foregroundColor(.white)
					}
					.shadow(color: .gray, radius: 1, x: 2, y: 2)
					Spacer()
				}
			)
			CCTabItem(tab: .notes)
		}
		.padding()
		.background(Color(.systemGroupedBackground))
	}
	
	private func CCTabItem(tab: Tab) -> some View {
		var systemName: String {
			switch tab {
			case .conversations: 	return "rectangle.stack.badge.play.fill"
			case .notes:			return "checklist"
			}
		}
		var tintColor: (light: Color, dark: Color) {
			switch tab {
			case .conversations: 	return (Color.logoLightRed, Color.logoDarkRed)
			case .notes: 			return (Color.logoLightBlue, Color.logoDarkBlue)
			}
		}
		return Button(
			action: {
				selectedIndex = tab
			}, label: {
				Spacer()
				Image(systemName: systemName)
					.font(.system(size: 28, weight: .bold))
					.foregroundColor(
						selectedIndex == tab ?
						tintColor.light : tintColor.dark
					)
				Spacer()
			}
		)
	}
	
}

struct MainTabView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer { .preview }
	
	static var previews: some View {
		container.MainTabView()
			.environmentObject(container)
	}
	
}
