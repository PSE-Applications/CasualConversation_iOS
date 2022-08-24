//
//  SettingView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/08/09.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

struct SettingView: View {
	
	@ObservedObject var viewModel: SettingViewModel
	
    var body: some View {
		VStack {
			List {
				InfomationSection()
				GeneralSection()
				ThemeSection()
				FeedbackSection()
				UnclassifiedSection()
			}
			.listStyle(.grouped)
			
			Text("@2022. Team Marcoda. All rights reserved.")
				.foregroundColor(.gray)
				.font(.caption)
		}
		.navigationTitle("Setting")
    }
	
}

extension SettingView {
	
	private func InfomationSection() -> some View {
		Section {
			
		} header: {
			Text("정보")
		}
	}
	
	private func GeneralSection() -> some View {
		Section {
			
		} header: {
			Text("일반")
		}
	}
	
	private func ThemeSection() -> some View {
		Section {
			HStack {
				Text("다크모드")
				Spacer()
				Button {
					
				} label: {
					
				}
				Button {
					
				} label: {
					
				}
				Button {
					
				} label: {
					
				}
			}
		} header: {
			Text("테마")
		}
	}
	
	private func FeedbackSection() -> some View {
		Section {
			Text("문의하기")
				.onTapGesture {
					print(#function)
				}
			Text("리뷰하기")
				.onTapGesture {
					print(#function)
				}
		} header: {
			Text("소통")
		}
	}
	
	private func UnclassifiedSection() -> some View {
		Section {
			NavigationLink(destination: {
				Text("오픈소스 라이선스")
			}, label: {
				Text("오픈소스 라이선스")
			})
			
			HStack {
				Text("버전")
				Spacer()
				Text("1.0.0")
					.font(.subheadline)
					.foregroundColor(.gray)
			}
		}
	}
	
}

// MARK: - Preview
struct SettingView_Previews: PreviewProvider {
	
    static var previews: some View {
		SettingView(viewModel: .init(dependency: .init()))
			.preferredColorScheme(.light)
		SettingView(viewModel: .init(dependency: .init()))
			.preferredColorScheme(.dark)
    }
	
}
