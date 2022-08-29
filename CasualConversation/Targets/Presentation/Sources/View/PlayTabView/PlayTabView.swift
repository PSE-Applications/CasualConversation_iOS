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
	
	@State private var isPlaying: Bool = false
	@State private var isEditing: Bool = false
	@State private var currentPoint: TimeInterval = 0
	
    var body: some View {
		VStack(alignment: .center) {
			TimeSlider()
			TimeLabels(
				current: viewModel.currentTime.toTimeString,
				duration: viewModel.duration.toTimeString
			)
			PlayControl()
		}
		.background(Color.ccGroupBgColor)
    }
	
}

extension PlayTabView {
	
	private func TimeSlider() -> some View {
		Slider(
			value: $currentPoint,
			in: viewModel.currentTime...viewModel.duration,
			onEditingChanged: { editing in
				self.isEditing = editing
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
					Text("\(item.rawValue)x")
						.foregroundColor(.logoDarkBlue)
						.font(.caption)
				})
			}
		} label: {
			Spacer()
			Text("\(viewModel.speed.rawValue)x")
				.foregroundColor(.logoDarkBlue)
				.font(.headline)
			Spacer()
		}
	}
	
	private func PlayButton() -> some View {
		Button {
			isPlaying.toggle()
		} label: {
			Spacer()
			Image(systemName: viewModel.isPlayingImageName(by: isPlaying))
				.font(.system(size: 44))
			Spacer()
		}
	}
	
	private func BackwardButton() -> some View {
		Button {
			
		} label: {
			Spacer()
			Image(systemName: "gobackward.5")
				.font(.system(size: 22))
			Spacer()
		}
	}
	
	private func GowardButton() -> some View {
		Button {
			
		} label: {
			Spacer()
			Image(systemName: "goforward.5")
				.font(.system(size: 22))
			Spacer()
		}
	}
	
	private func NextPinButton() -> some View {
		Button(
			action: {
				
			}, label: {
				Spacer()
				Image(systemName: "forward.end.alt.fill")
					.font(.system(size: 16))
				Spacer()
			}
		)
		.foregroundColor(.logoDarkBlue)
		.disabled(!isPlaying)
		.opacity(viewModel.nextPinButtonOpacity(by: isPlaying))
	}
	
}

#if DEBUG // MARK: - Preview
struct PlayTabView_Previews: PreviewProvider {
    
	static var container: PresentationDIContainer { .preview }
	
	static var previews: some View {
		container.PlayTabView()
			.previewLayout(.sizeThatFits)
			.preferredColorScheme(.light)
		container.PlayTabView()
			.previewLayout(.sizeThatFits)
			.preferredColorScheme(.dark)
    }
	
}
#endif
