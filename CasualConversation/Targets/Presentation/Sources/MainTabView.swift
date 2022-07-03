//
//  MainTabView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

public struct MainTabView: View {
	
	public init(viewModel: MainTabViewModel) {
		self.viewModel = viewModel
	}

	public var body: some View {
        Text("Hello world")
    }
    
}

struct MainTabView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainTabView()
    }
    
}
