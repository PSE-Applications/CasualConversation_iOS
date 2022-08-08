//
//  MainTabView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

public struct MainTabView: View {
	
	private enum Tab: Int, CaseIterable, Hashable {
		case conversations, record, notes
		
		var title: String { Self.titles[self.rawValue] }
		var imageSystemName: String { Self.tabBarImageNames[self.rawValue] }
		var tintColor: (light: Color, dark: Color) { Self.tintColors[self.rawValue] }
		
		private static let titles = [
			"Casual Conversation", "Recording", "Notes"
		]
		private static let tabBarImageNames = [
			"rectangle.stack.badge.play.fill", "mic.fill.badge.plus", "checklist"
		]
		private static let tintColors: [(Color, Color)] = [
			(.logoLightRed, .logoDarkRed),
			(.logoLightGreen, .logoDarkGreen),
			(.logoLightBlue, .logoDarkBlue)
		]
	}
	
	@EnvironmentObject private var sceneDIContainer: PresentationDIContainer
	@ObservedObject private var viewModel: MainTabViewModel
	@State private var selectedIndex: Tab = .conversations
	@State private var isPresentedRecordView: Bool = false
	
	public init(viewModel: MainTabViewModel) {
		self.viewModel = viewModel
	}

	public var body: some View {
		NavigationView {
			VStack {
				Spacer()
				ZStack {
					switch selectedIndex {
					case .conversations:
						Text("CoversationList View")
					case .notes:
						Text("NoteSet View")
					default:
						Text("Error Page")
					}
				}
				Spacer()
				TabView
			}
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					NavigationLink(destination: Text("Setting View")) {
						Image(systemName: "gear")
					}
				}
			}
			.navigationBarTitle(selectedIndex.title)
			.fullScreenCover(isPresented: $isPresentedRecordView) {
				Button {
					isPresentedRecordView.toggle()
				} label: {
					Text("FullScreen Cover")
				}
			}
		}
		.accentColor(.logoDarkGreen)
    }
    
}

extension MainTabView {
	
	var TabView: some View {
		HStack(alignment: .center) {
			ForEach(Tab.allCases, id: \.rawValue) { index in
				Button {
					if index == .record {
						isPresentedRecordView.toggle()
						return
					} else {
						selectedIndex = index
					}
				} label: {
					Spacer()
					if index == .record {
						ZStack(alignment: .center) {
							Circle()
								.fill(Color.logoLightGreen)
							Image(systemName: index.imageSystemName)
								.font(.system(size: 44))
								.foregroundColor(.white)
						}
						.frame(height: 70, alignment: .top)
						.shadow(color: .gray, radius: 1, x: 2, y: 2)
					} else {
						Image(systemName: index.imageSystemName)
							.font(.system(size: 24, weight: .bold))
							.foregroundColor(
								selectedIndex == index ?
								index.tintColor.light : index.tintColor.dark
							)
					}
					Spacer()
				}
			}
		}
		.background(Color(UIColor.systemGroupedBackground))
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
