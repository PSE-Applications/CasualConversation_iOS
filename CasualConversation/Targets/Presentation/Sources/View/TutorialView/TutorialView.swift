//
//  TutorialView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/09/19.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

struct TutorialView: View {
	
	@Environment(\.presentationMode) var presentationMode
	private let names = (0...4).map({ "iphoneX_\($0)" })
	
	var body: some View {
		TabView {
			ForEach(Array(names.enumerated()), id: \.offset) { index, name in
				Image(name)
					.resizable()
					.scaledToFit()
					.cornerRadius(50)
					.overlay {
						if index == names.count - 1 {
							VStack {
								Spacer()
								Button(
									action: {
										self.presentationMode.wrappedValue.dismiss()
										Preference.shared.isDoneTutorial = true
									}, label: {
										Text("앱 시작하기")
											.font(.system(size: 16, weight: .bold, design: .rounded))
											.shadow(color: .lightRecordColor, radius: 1, x: 1, y: 1)
									}
								)
								.foregroundColor(.white)
								.buttonStyle(.borderedProminent)
								.buttonBorderShape(.roundedRectangle)
								.tint(.iconMainColor)
								Rectangle()
									.fill(Color.clear)
									.frame(height: 40)
							}
						}
					}
			}
		}
		.tabViewStyle(.page(indexDisplayMode: .always))
		.background(Color.lightRecordColor)
	}
	
}

struct TutorialView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer { .preview }
	
	static var previews: some View {
		TutorialView()
			.environmentObject(container)
			.preferredColorScheme(.light)
		TutorialView()
			.environmentObject(container)
			.preferredColorScheme(.dark)
	}
	
}
