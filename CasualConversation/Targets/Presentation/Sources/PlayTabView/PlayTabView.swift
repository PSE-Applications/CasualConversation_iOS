//
//  PlayTabView.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/10.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

struct PlayTabView: View {
	
	@EnvironmentObject private var container: PresentationDIContainer
	@ObservedObject var viewModel: PlayTabViewModel
	
	@State private var isPlaying: Bool = false
	
    var body: some View {
		VStack(alignment: .center) {
			TimeProgress()
			TimeLabels(
				current: viewModel.currentTime.toTimeString,
				duration: viewModel.duration.toTimeString
			)
			PlayControl()
		}
    }
	
}

extension PlayTabView {
	
	private func TimeProgress() -> some View {
		ProgressView(
			value: viewModel.currentTime,
			total: viewModel.duration
		)
		.progressViewStyle(.linear)
	}
	
	private func TimeLabels(current: String, duration: String) -> some View {
		HStack(alignment: .top) {
			Text(current)
			Spacer()
			Text(duration)
		}
		.foregroundColor(.gray)
		.font(.caption)
	}
	
	private func PlayControl() -> some View {
		HStack(alignment: .center) {
			SpeedMenu()
			BackwardButton()
			PlayButton()
			GowardButton()
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
	
}

struct PlayTabView_Previews: PreviewProvider {
    
	static var container: PresentationDIContainer { .preview }
	
	static var previews: some View {
		container.PlayTabView()
			.environmentObject(container)
			.previewLayout(.sizeThatFits)
    }
	
}
