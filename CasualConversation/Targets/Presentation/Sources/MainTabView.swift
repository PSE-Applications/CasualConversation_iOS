//
//  MainTabView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

public struct MainTabView: View {
	
	@EnvironmentObject
	private var sceneDIContainer: PresentationDIContainer
	
	@ObservedObject
	private var viewModel: MainTabViewModel
	
	public init(viewModel: MainTabViewModel) {
		self.viewModel = viewModel
	}

	public var body: some View {
        Text("Hello world")
    }
    
}

#if DEBUG
struct MainTabView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer {
		.preview
	}
	
	static var previews: some View {
		container.MainTabView()
	}
}
#endif
