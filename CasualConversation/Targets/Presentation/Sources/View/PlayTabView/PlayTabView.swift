//
//  PlayTabView.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/10.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

struct PlayTabView: View {
	
	@ObservedObject var viewModel: PlayTabViewModel
		
    var body: some View {
		VStack(alignment: .center) {
			TimeSlider()
			TimeLabels(
				current: viewModel.currentTime.formattedToDisplayTime,
				duration: viewModel.duration.formattedToDisplayTime
			)
			.overlay {
				if viewModel.disabledPlaying {
					Text("녹음 파일 없음")
						.font(.headline)
				}
			}
			PlayControl()
		}
		.background(Color.ccGroupBgColor)
		.onAppear {
			viewModel.setupPlaying()
		}
		.onDisappear {
			viewModel.finishPlaying()
		}
	}
	
}

extension PlayTabView {
	
	private func TimeSlider() -> some View {
		Slider(
			value: $viewModel.currentTime,
			in: .zero...viewModel.duration,
			onEditingChanged: { isEditing in
				if isEditing {
					viewModel.editingSliderPointer()
				} else {
					viewModel.editedSliderPointer()
				}
			}
		)
		.padding([.leading, .trailing])
	}
	
	private func TimeLabels(current: String, duration: String) -> some View {
		HStack(alignment: .top) {
			Text(current)
			Spacer()
			Text(duration)
		}
		.padding([.leading, .trailing])
		.foregroundColor(.gray)
		.font(.caption)
	}
	
	private func PlayControl() -> some View {
		HStack(alignment: .center) {
			SpeedMenu()
			BackwardButton()
			PlayButton()
			GowardButton()
			NextPinButton()
		}
		.foregroundColor(.logoLightBlue)
	}
	
	private func SpeedMenu() -> some View {
		Menu {
			ForEach(PlayTabViewModel.Speed.allCases, id: \.self) { item in
				Button(action: {
					viewModel.speed = item
				}, label: {
					Text(item.description)
						.foregroundColor(.logoDarkBlue)
						.font(.caption)
				})
			}
		} label: {
			Spacer()
			Text(viewModel.speed.description)
				.foregroundColor(.logoDarkBlue)
				.font(.headline)
			Spacer()
		}
	}
	
	private func PlayButton() -> some View {
		Button {
			if viewModel.isPlaying {
				viewModel.pausePlaying()
			} else {
				viewModel.startPlaying()
			}
		} label: {
			Spacer()
			Image(systemName: viewModel.isPlayingImageName)
				.font(.system(size: 44))
			Spacer()
		}
		.disabled(viewModel.disabledPlaying)
	}
	
	private func BackwardButton() -> some View {
		Button {
			viewModel.skip(.back)
		} label: {
			Spacer()
			Image(systemName: "gobackward." + viewModel.skipTime)
				.font(.system(size: 22))
			Spacer()
		}
		.disabled(viewModel.disabledPlaying)
		.opacity(viewModel.disabledPlayingOpacity)
	}
	
	private func GowardButton() -> some View {
		Button {
			viewModel.skip(.forward)
		} label: {
			Spacer()
			Image(systemName: "goforward." + viewModel.skipTime)
				.font(.system(size: 22))
			Spacer()
		}
		.disabled(viewModel.disabledPlaying)
		.opacity(viewModel.disabledPlayingOpacity)
	}
	
	private func NextPinButton() -> some View {
		Button(
			action: {
				viewModel.skip(.next)
			}, label: {
				Spacer()
				Image(systemName: "forward.end.alt.fill")
					.font(.system(size: 16))
				Spacer()
			}
		)
		.foregroundColor(.logoDarkBlue)
		.disabled(viewModel.nextPin == nil)
		.opacity(viewModel.nextPinButtonOpacity)
	}
	
}

#if DEBUG // MARK: - Preview
struct PlayTabView_Previews: PreviewProvider {
    
	static var container: PresentationDIContainer { .preview }
	
	static var previews: some View {
		container.PlayTabView(with: .empty)
			.previewLayout(.sizeThatFits)
			.preferredColorScheme(.light)
		container.PlayTabView(with: .empty)
			.previewLayout(.sizeThatFits)
			.preferredColorScheme(.dark)
    }
	
}
#endif
