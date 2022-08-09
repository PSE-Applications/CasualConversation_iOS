//
//  RecordView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

struct RecordView: View {
	
	let viewModel: RecordViewModel
	
	@Environment(\.presentationMode) private var presentationMode
	
	@State private var titleText: String = Date().formattedString
	@State private var isRecording: Bool = false

	var body: some View {
		VStack(alignment: .leading) {
			HStack(alignment: .center) {
				Button {
					presentationMode.wrappedValue.dismiss()
				} label: {
					Text("취소")
						.font(.headline)
						.foregroundColor(.logoLightGreen)
				}
				Spacer()
				Text("Casual Conversation")
					.font(.headline)
					.foregroundColor(.white)
				Spacer()
				Button {
					// Update
					presentationMode.wrappedValue.dismiss()
				} label: {
					Text("완료")
						.font(.headline)
						.foregroundColor(.logoLightGreen)
				}
			}
			Divider()
			Spacer()
			VStack(alignment: .center) {
				Rectangle()
					.foregroundColor(.recordShadow)
			}
			.padding()
			Spacer()
			RecordControl
			Spacer()
		}
		.padding()
		.background(Color.recordBackground)
		.preferredColorScheme(.dark)
	}
	
	var RecordControl: some View {
		HStack(alignment: .center) {
			Button() {
				isRecording = false
			} label: {
				Spacer()
				ZStack {
					Image(systemName: "stop.fill")
						.foregroundColor(.white)
						.font(.system(size: 34))
						.shadow(color: .gray, radius: 1, x: 2, y: 2)
				}
				Spacer()
			}
			Spacer()
			Button() {
				isRecording.toggle()
			} label: {
				ZStack {
					Circle()
						.stroke(lineWidth: 2)
						.frame(width: 66, height: 66, alignment: .center)
						.foregroundColor(.white)
					if isRecording {
						ZStack {
							Image(systemName: "circle.fill")
								.foregroundColor(.logoDarkRed)
								.font(.system(size: 58))
								.shadow(color: .black, radius: 1, x: 1, y: 1)
							Image(systemName: "pause.fill")
								.foregroundColor(.logoLightRed)
								.font(.system(size: 34))
								.shadow(color: .black, radius: 1, x: 1, y: 1)
						}
					} else {
						Image(systemName: "circle.fill")
							.foregroundColor(.logoLightRed)
							.font(.system(size: 58))
							.shadow(color: .black, radius: 1, x: 1, y: 1)
					}
				}
			}
			Spacer()
			Button() {
				
			} label: {
				Spacer()
				ZStack {
					Image(systemName: "pin")
						.foregroundColor(.logoLightBlue)
						.font(.system(size: 26))
						.shadow(color: .recordShadow, radius: 1, x: 2, y: 2)
				}
				Spacer()
			}
		}
	}
}

#if DEBUG
struct RecordView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer {
		.preview
	}
	
	static var previews: some View {
		container.RecordView()
	}

}
#endif
