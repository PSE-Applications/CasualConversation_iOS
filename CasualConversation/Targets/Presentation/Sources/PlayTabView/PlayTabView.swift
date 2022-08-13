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
	@EnvironmentObject private var container: PresentationDIContainer
	
	@State private var isPlaying: Bool = false
	
	private var isPlayingImageName: String { isPlaying ? "pause.circle.fill" : "play.circle.fill" }
	
    var body: some View {
		VStack(alignment: .center) {
			ProgressView(value: viewModel.currentTime, total: viewModel.duration)
				.progressViewStyle(.linear)
			TimeLabels(
				current: viewModel.currentTime.toTimeString,
				duration: viewModel.duration.toTimeString
			)
			HStack(alignment: .center) {
				SpeedMenu()
				BackwardButton()
				PlayButton()
				GowardButton()
			}
			.foregroundColor(.logoLightBlue)
		}
    }
	
}

extension PlayTabView {
	
	private func TimeLabels(current: String, duration: String) -> some View {
		HStack(alignment: .top) {
			Text(current)
			Spacer()
			Text(duration)
		}
		.foregroundColor(.gray)
		.font(.caption)
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
			Image(systemName: isPlayingImageName)
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
