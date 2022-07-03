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

//struct MainTabView_Previews: PreviewProvider {
//
//	static let viewModel: ViewModelProtocol = MainTabViewModel(dependency: .init())
//    static var previews: some View {
//		MainTabView(viewModel: viewModel)
//    }
//    
//}
