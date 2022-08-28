//
//  RecordView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

struct RecordView: View {
	
	@Environment(\.presentationMode) private var presentationMode
	
	@ObservedObject var viewModel: RecordViewModel
	
	@State private var cancelAlert: Bool = false
	@State private var stopAlert: Bool = false

	var body: some View {
		NavigationView {
			VStack(alignment: .leading) {
				RecordContent()
				RecordControl()
			}
			.padding()
			.background(Color.recordBackground)
			.navigationTitle("Casual Conversation")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					CancelToolBarButton()
				}
			}
		}
		.preferredColorScheme(.dark)
	}
	
}

extension RecordView {
	
	private func CancelToolBarButton() -> some View {
		Button {
			cancelAlert.toggle()
		} label: {
			Text("취소")
				.font(.headline)
				.foregroundColor(.logoLightGreen)
		}
		.alert("녹음 취소", isPresented: $cancelAlert) {
			Button("삭제", role: .destructive) {
				viewModel.cancelRecording()
				presentationMode.wrappedValue.dismiss()
			}
			Button("취소", role: .cancel) { }
		} message: {
			Text("녹음물은 저장되지 않습니다")
		}
	}
	
	private func RecordContent() -> some View {
		VStack(alignment: .center) {
			Spacer()
			InputTitle()
			Spacer()
		}
		.background(Color.recordShadow)
		.padding()
	}
	
	private func InputTitle() -> some View {
		TextField("InputTitle",
				  text: $viewModel.inputTitle,
				  prompt: Text("녹음 제목을 입력하세요")
		)
		.multilineTextAlignment(.center)
	}
	
	private func RecordControl() -> some View {
		HStack(alignment: .center) {
			StopButton()
			Spacer()
			RecordButton()
			Spacer()
			PinButton()
		}
	}
	
	private func StopButton() -> some View {
		Button(
			action: {
				stopAlert.toggle()
			}, label: {
				Spacer()
				ZStack {
					Image(systemName: "stop.fill")
						.foregroundColor(viewModel.buttonColorByisEditing)
						.font(.system(size: 34))
						.shadow(color: .logoDarkBlue, radius: 1, x: 2, y: 2)
				}
				Spacer()
			}
		)
		.alert("녹음 완료", isPresented: $stopAlert) {
			Button("취소", role: .cancel) { }
			Button("저장") {
				viewModel.stopRecording()
				presentationMode.wrappedValue.dismiss()
			}
		} message: {
			Text("녹음을 중지하고 녹음물을 저장하시겠습니까?")
		}
		.disabled(!viewModel.isStartedRecording)
	}
	
	private func RecordButton() -> some View {
		Button(
			action: {
				if viewModel.isStartedRecording {
					viewModel.pauseRecording()
				} else {
					viewModel.startRecording()
				}
				viewModel.isStartedRecording.toggle()
			}, label: {
				ZStack {
					Circle()
						.stroke(lineWidth: 2)
						.frame(width: 66, height: 66, alignment: .center)
						.foregroundColor(.white)
					if viewModel.isStartedRecording {
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
							.shadow(color: .logoDarkBlue, radius: 1, x: 1, y: 1)
					}
				}
			}
		)
	}
	
	private func PinButton() -> some View {
		Button(
			action: {
				viewModel.putOnPin()
			}, label: {
				Spacer()
				ZStack {
					Image(systemName: "pin")
						.foregroundColor(viewModel.buttonColorByisEditing)
						.font(.system(size: 26))
						.shadow(color: .logoDarkBlue, radius: 1, x: 2, y: 2)
				}
				Spacer()
			}
		)
		.disabled(!viewModel.isStartedRecording)
	}
	
}

#if DEBUG // MARK: - Preview
struct RecordView_Previews: PreviewProvider {
	
	static var container: PresentationDIContainer { .preview }
	
	static var previews: some View {
		container.RecordView()
	}

}
#endif
