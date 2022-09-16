//
//  MailView.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/25.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {

	@Binding var isShowing: Bool
	@Binding var result: Result<MFMailComposeResult, Error>?

	class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

		@Binding var isShowing: Bool
		@Binding var result: Result<MFMailComposeResult, Error>?

		init(
			isShowing: Binding<Bool>,
			result: Binding<Result<MFMailComposeResult, Error>?>
		) {
			_isShowing = isShowing
			_result = result
		}

		func mailComposeController(_ controller: MFMailComposeViewController,
								   didFinishWith result: MFMailComposeResult,
								   error: Error?) {
			defer { isShowing = false }
			guard let error = error else {
				self.result = .success(result)
				return
			}
			self.result = .failure(error)
		}
	}

	func makeCoordinator() -> Coordinator {
		return Coordinator(isShowing: $isShowing, result: $result)
	}

	func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
		let vc = MFMailComposeViewController()
		vc.mailComposeDelegate = context.coordinator
		// TODO: Mail 내용 구상 필요
		vc.setToRecipients(["pse.applications@gmail.com"])
		vc.setSubject("[CC_iOS] 문의하기 \(Date().formattedString)")
		let deviceModel = "Model : \(Preference.shared.deviceName)"
		let osVersion = "OS : \(UIDevice.current.systemVersion)"
		let appVersion = "App Version : \(Preference.shared.appVersion)"
		let body = ["[User Info]", deviceModel, osVersion, appVersion].joined(separator: "\n")
		vc.setMessageBody(body, isHTML: false)
		return vc
	}

	func updateUIViewController(_ uiViewController: MFMailComposeViewController,
								context: UIViewControllerRepresentableContext<MailView>) {

	}
	
}
