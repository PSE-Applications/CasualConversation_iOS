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
	@State private var isEditing: Bool = false
	@State private var isPresentedDeniedAlert: Bool = false

	var body: some View {
		NavigationView {
			VStack(alignment: .leading) {
				RecordContent()
				RecordControl()
			}
			.padding()
			.background(Color.darkRecordColor)
			.navigationTitle("Casual Conversation")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					CancelToolBarButton()
				}
				ToolbarItem(placement: .keyboard) {
					Button(
						action: {
							dismissKeyboard()
						}, label: {
							Image(systemName: "keyboard.chevron.compact.down")
						}
					)
					.foregroundColor(.ccTintColor)
					Spacer()
				}
			}
		}
		.preferredColorScheme(.dark)
		.onAppear {
			viewModel.setupRecording()
			viewModel.recordPermission()
		}
		.onDisappear {
			viewModel.finishRecording()
		}
	}
	
}

extension RecordView {
	
	private func CancelToolBarButton() -> some View {
		Button {
			cancelAlert.toggle()
		} label: {
			Text("취소")
				.font(.headline)
				.foregroundColor(.ccTintColor)
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
			RecordInfo()
			Spacer()
			ConversationInfo()
		}
		.background(Color
			.lightRecordColor
			.cornerRadius(25)
		)
		.padding()
	}
	
	private func RecordInfo() -> some View {
		VStack {
			Spacer(minLength: 30)
			HStack {
				Spacer()
				Image(systemName: "circle.fill")
					.foregroundColor(viewModel.onRecordingTintColor)
					.opacity(viewModel.onRecordingOpacity)
				Text(viewModel.currentTime.formattedToDisplayTime)
					.foregroundColor(viewModel.currentTimeTintColor)
					.font(.largeTitle)
				Spacer()
			}
			Spacer()
			List {
				ForEach(viewModel.pins, id: \.self) { time in
					HStack {
						Text("📌 \(time.formattedToDisplayTime)")
						Spacer()
						Button(
							action: {
								viewModel.remove(pin: time)
							}, label: {
								Image(systemName: "delete.backward")
									.foregroundColor(.logoLightRed)
							}
						)
					}
					.listRowBackground(Color.clear)
				}
			}
			.padding()
			.listStyle(.plain)
			.background(Color.clear)
		}
	}
	
	private func ConversationInfo() -> some View {
		GroupBox {
			if isEditing {
				InputTitle()
				InputTopic()
				InputMembers()
			}
			Button(
				action: {
					withAnimation {
						isEditing.toggle()
					}
				}, label: {
					HStack {
						Text("Conversation Information")
							.font(.headline)
						Spacer()
						Image(systemName: "chevron.right")
							.foregroundColor(.logoDarkGreen)
							.rotationEffect(.degrees(isEditing ? -90.0 : 0.0))
					}
				}
			)
			.tint(.ccTintColor)
		}
		.padding()
	}
	
	private func InputTitle() -> some View {
		TextField("InputTitle",
				  text: $viewModel.inputTitle,
				  prompt: Text("녹음 제목을 입력하세요")
		)
		.multilineTextAlignment(.center)
		.showClearButton($viewModel.inputTitle)
		.cornerRadius(10)
	}
	
	private func InputTopic() -> some View {
		TextField("InputTopic",
				  text: $viewModel.inputTopic,
				  prompt: Text("대화 주제를 입력하세요")
		)
		.multilineTextAlignment(.center)
		.showClearButton($viewModel.inputTopic)
		.cornerRadius(10)
	}
	
	@ViewBuilder
	private func InputMembers() -> some View {
		HStack {
			TextField("InputMembers",
					  text: $viewModel.inputMember,
					  prompt: Text("참여자를 추가하세요")
			)
			.multilineTextAlignment(.center)
			.showClearButton($viewModel.inputMember)
			.cornerRadius(10)
			.onSubmit {
				viewModel.addMember()
			}
		}
		if viewModel.members.count > 0 {
			ScrollView(.horizontal, showsIndicators: true) {
				let rows = [ GridItem(.fixed(30)) ]
				LazyHGrid(rows: rows) {
					ForEach(viewModel.members, id: \.name) { member in
						ZStack {
							Rectangle()
								.cornerRadius(15)
								.foregroundColor(.darkRecordColor)
							HStack {
								Text(member.emoji)
								Text(member.name)
									.font(.headline)
								Button(
									action: {
										viewModel.remove(member: member)
									}, label: {
										Image(systemName: "delete.backward")
											.foregroundColor(.logoLightRed)
									}
								)
							}
							.padding()
						}
					}
				}
				.frame(height: 32, alignment: .center)
				.padding()
			}
		}
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
						.foregroundColor(viewModel.stopButtonTintColor)
						.font(.system(size: 34))
						.shadow(color: .logoDarkBlue, radius: 1, x: 2, y: 2)
				}
				Spacer()
			}
		)
		.disabled(!viewModel.canSaveRecording)
		.alert("녹음 완료", isPresented: $stopAlert) {
			Button("취소", role: .cancel) { }
			Button("저장") {
				viewModel.stopRecording()
				presentationMode.wrappedValue.dismiss()
			}
		} message: {
			Text("녹음을 중지하고 녹음물을 저장하시겠습니까?")
		}
	}
	
	private func RecordButton() -> some View {
		Button(
			action: {
				if viewModel.isPermitted {
					if viewModel.isRecording {
						viewModel.pauseRecording()
					} else {
						viewModel.startRecording()
					}
				} else {
					self.isPresentedDeniedAlert.toggle()
				}
			}, label: {
				ZStack {
					Circle()
						.stroke(lineWidth: 2)
						.frame(width: 66, height: 66, alignment: .center)
						.foregroundColor(.white)
					if viewModel.isRecording {
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
		.alert(
			"마이크 접근 허용 필요",
			isPresented: $isPresentedDeniedAlert,
			actions: {
				Button("확인", role: .cancel) { }
			}, message: {
				Text("설정 > CasualConversation > CASUALCONVERSATION 접근허용 > 마이크 허용\n 스위치를 허용해주세요")
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
						.foregroundColor(viewModel.pinButtonTintColor)
						.font(.system(size: 26))
						.shadow(color: .logoDarkBlue, radius: 1, x: 2, y: 2)
				}
				Spacer()
			}
		)
		.disabled(!viewModel.isRecording)
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
