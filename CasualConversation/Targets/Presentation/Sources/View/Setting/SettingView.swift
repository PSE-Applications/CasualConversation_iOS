//
//  SettingView.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/09.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

struct SettingView: View {
	
	@Environment(\.colorScheme) private var systemColorScheme
	@EnvironmentObject private var configurations: PresentationConfiguarations
	
	@ObservedObject var viewModel: SettingViewModel
	
	@State private var isShowingMailView: Bool = false
	
    var body: some View {
		VStack {
			Form {
				InfomationSection()
				GeneralSection()
				ThemeSection()
				FeedbackSection()
				UnclassifiedSection()
			}
			.listStyle(.grouped)
			
			Text("@2022. All rights reserved by Team Marcoda.")
				.foregroundColor(.gray)
				.font(.caption)
		}
		.background(Color.ccGroupBgColor)
		.navigationTitle("Setting")
		.navigationBarTitleDisplayMode(.inline)
    }
	
}

extension SettingView {
	
	@ViewBuilder
	private func InfomationSection() -> some View {
		NavigationLink(
			destination: {
				Form {
					AcademyInfo()
					AcademyPages()
				}
			}, label: {
				HStack {
					Image(viewModel.logoImageName(by: systemColorScheme))
						.resizable()
						.frame(width: 41.7, height: 48)
					Text("What is Casual Conversation?")
						.font(.headline)
				}
			}
		)
	}
	
	@ViewBuilder
	private func AcademyInfo() -> some View {
		VStack(alignment: .center) {
			Image(viewModel.titleImageName(by: systemColorScheme))
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(height: 100)
			Text("프린서플어학원 CC Time 프로그램")
				.font(.headline)
		}
		VStack(alignment: .leading) {
			Text("언제 어디서나 영어회화로 가벼운 인사부터 다양한 주제의 대화를 나누는 영어회화 학습방법입니다.")
				.font(.subheadline)
			Text("주제 및 발음기호 등 학습 정보는 PSE에서 제공합니다.")
				.font(.caption)
				.foregroundColor(.gray)
		}
		.lineLimit(nil)
		.fixedSize(horizontal: false, vertical: true)
	}
	
	@ViewBuilder
	private func AcademyPages() -> some View {
		Group {
			Link("🔍 프린서플어학원 알아보기", destination: configurations.mainURL)
			Link("☕️ 네이버카페", destination: configurations.cafeURL)
			Link("🖥 e-Learning", destination: configurations.eLearningURL)
			Link("👀 정규반 맛보기 강의", destination: configurations.tasteURL)
			Link("📄 온라인 레벨테스트", destination: configurations.testURL)
			Button("📞 문의전화") {
				UIApplication.shared.open(configurations.receptionTel)
			}
		}
		.tint(.logoDarkGreen)
	}
	
	private func GeneralSection() -> some View {
		Section {
			LockScreen()
		} header: {
			Text("일반")
		}
	}
	
	private func LockScreen() -> some View {
		HStack {
			Toggle("화면잠금 방지", isOn: $viewModel.lockScreen)
				.tint(.ccTintColor)
		}
	}
	
	private func ThemeSection() -> some View {
		Section {
			DarkMode()
		} header: {
			Text("테마")
		}
	}
	
	private func DarkMode() -> some View {
		Picker("디스플레이 모드 설정", selection: $viewModel.displayMode) {
			ForEach(DisplayMode.allCases, id: \.self) { condition in
				Text(condition.description)
					.tag(condition)
			}
		}
	}
	
	private func FeedbackSection() -> some View {
		Section {
			Button("문의하기") {
				self.isShowingMailView.toggle()
			}
			.sheet(isPresented: $isShowingMailView) {
				MailView(
					isShowing: $isShowingMailView,
					result: $viewModel.mailSendedResult
				)
			}
			Text("리뷰하기")
				.onTapGesture {
					print(#function)
				}
			Button("공유하기") {
				
			}
		} header: {
			Text("소통")
		}
		.tint(.primary)
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
			
			NavigationLink(destination: {
				Text("개발자 정보")
			}, label: {
				Text("개발자 정보")
			})
		} header: {
			Text("앱 정보")
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
