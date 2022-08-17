//
//  View+.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/14.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

extension View {

	func dismissKeyboard() {
		UIApplication.shared
			.sendAction(#selector(UIResponder.resignFirstResponder),
						to: nil, from: nil, for: nil)
	}
	
}
