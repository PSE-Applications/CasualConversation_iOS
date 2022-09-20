//
//  HalfSheet.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/26.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

struct HalfSheet<Content>: UIViewControllerRepresentable where Content : View {

	private let content: Content
	private let isFlexible: Bool
	
	@inlinable init(isFlexible: Bool, @ViewBuilder content: () -> Content) {
		self.content = content()
		self.isFlexible = isFlexible
	}
	
	func makeUIViewController(context: Context) -> HalfSheetController<Content> {
		return HalfSheetController(rootView: content, isFlexible: isFlexible)
	}
	
	func updateUIViewController(_: HalfSheetController<Content>, context: Context) { }
	
}

class HalfSheetController<Content>: UIHostingController<Content> where Content : View {
	
	let isFlexible: Bool
	
	init(rootView: Content, isFlexible: Bool) {
		self.isFlexible = isFlexible
		super.init(rootView: rootView)
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if let presentation = sheetPresentationController {
			presentation.detents = self.isFlexible ?  [.medium(), .large()] :  [.medium()]
			presentation.prefersGrabberVisible = self.isFlexible
		}
	}
}

