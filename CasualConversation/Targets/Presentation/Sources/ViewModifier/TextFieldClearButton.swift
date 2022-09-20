//
//  TextFieldClearButton.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/14.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

extension View {
	
	func showClearButton(_ text: Binding<String>) -> some View {
		self.modifier(TextFieldClearButton(text: text))
	}
	
}

struct TextFieldClearButton: ViewModifier {
	
	@Binding var text: String
	
	func body(content: Content) -> some View {
		content
			.overlay {
				if !text.isEmpty {
					HStack {
						Spacer()
						Button(
							action: {
								text = ""
							}, label: {
								Image(systemName: "multiply.circle.fill")
							}
						)
						.foregroundColor(.secondary)
						.padding(.trailing, 4)
					}
				}
			}
	}
}
