//
//  MainTabView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

struct MainTabView: View {
	
	@EnvironmentObject private var container: PresentationDIContainer
	@ObservedObject var viewModel: MainTabViewModel
	
	@State private var selectedIndex: MainTabViewModel.Tab = .conversations
	@State private var isPresentedRecordView: Bool = false

	var body: some View {
		NavigationView {
			MainContent()
				.background(Color.ccBgColor)
				.overlay {
					VStack {
						Spacer()
						MainTab()
					}
				}
				.navigationTitle(viewModel.title(by: selectedIndex))
				.navigationBarTitleDisplayMode(.large)
				.toolbar {
					ToolbarItem(placement: .navigationBarTrailing) {
						SettingToolbarLink()
					}
				}
				.fullScreenCover(isPresented: $isPresentedRecordView) {
					container.RecordView()
				}
		}
    }

}

extension MainTabView {
	
	private func SettingToolbarLink() -> some View {
		NavigationLink(destination: container.SettingView()) {
			Image(systemName: "gear")
		}
	}
	
	@ViewBuilder
	private func MainContent() -> some View {
		switch selectedIndex {
		case .conversations:
			container.ConversationListView()
		case .notes:
			container.NoteSetView()
		}
	}
	
	private func MainTab() -> some View {
		HStack(alignment: .center) {
			CCTabItem(tab: .conversations)
			RecordButton()
			CCTabItem(tab: .notes)
		}
		.padding()
		.background(Color.ccGroupBgColor)
	}
	
	private func RecordButton() -> some View {
		Button(
			action: {
				isPresentedRecordView.toggle()
			}, label: {
				Spacer()
				ZStack(alignment: .center) {
					Circle()
						.fill(Color.ccTintColor)
						.frame(height: 74)
					Image(systemName: "mic.fill.badge.plus")
						.font(.system(size: 44))
						.foregroundColor(.white)
				}
				.shadow(color: .black, radius: 1, x: 1, y: 1)
				Spacer()
			}
		)
	}
	
	private func CCTabItem(tab: MainTabViewModel.Tab) -> some View {
		Button(
			action: {
				selectedIndex = tab
			}, label: {
				Spacer()
				Image(systemName: viewModel.tabItemImageName(by: tab))
					.font(.system(size: 28, weight: .bold))
					.foregroundColor(
						viewModel.tabItemTintColor(from: tab, by: selectedIndex)
					)
				Spacer()
			}
		)
	}
	
}

#if DEBUG // MARK: - Preview
struct MainTabView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer { .preview }
	
	static var previews: some View {
		container.MainTabView()
			.environmentObject(container)
			.preferredColorScheme(.light)
		container.MainTabView()
			.environmentObject(container)
			.preferredColorScheme(.dark)
	}
	
}
#endif
