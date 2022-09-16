//
//  ActivityView.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/09/16.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
	@Binding var isPresented: Bool
	
	public func makeUIViewController(context: Context) -> UIViewController {
		UIViewController()
	}
	
	public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
		guard let url = URL(string: "https://apps.apple.com/kr/app/id1642134370/") else {
			return
		}
		let shareItems: [Any] = [url]
		
		let activityViewController = UIActivityViewController(
			activityItems: shareItems,
			applicationActivities: nil
		)
		
		activityViewController.excludedActivityTypes = [.postToVimeo]
		
		if isPresented && uiViewController.presentedViewController == nil {
			uiViewController.present(activityViewController, animated: true)
		}
		activityViewController.completionWithItemsHandler = { (_, _, _, _) in
			isPresented = false
		}
	}
	
}
