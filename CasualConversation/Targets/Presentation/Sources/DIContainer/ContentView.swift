//
//  ContentView.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/08.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

public struct ContentView: View {
	
	@EnvironmentObject private var container: PresentationDIContainer
	
	public init() {}
	
	public var body: some View {
		container.MainTabView()
    }
	
}

#if DEBUG

struct ContentView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer { .preview }
	
    static var previews: some View {
        ContentView()
			.environmentObject(container)
    }
}

#endif
