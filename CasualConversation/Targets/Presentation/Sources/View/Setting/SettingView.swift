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
	
	@State private var isPresentedTutorial: Bool = false
	@State private var isShowingMailView: Bool = false
	@State private var isShowingActivityView: Bool = false
	
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
			Text("언제 어디서나 가벼운 인사부터 다양한 주제의 대화를 나누는 영어회화 학습방법입니다")
				.font(.subheadline)
			Text("주제 및 발음기호 등 학습 정보는 PSE에서 제공합니다")
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
			Tutorial()
			LockScreen()
			SkipTimeSelection()
		} header: {
			Text("일반")
		}
	}
	
	private func Tutorial() -> some View {
		Button(
			action: {
				self.isPresentedTutorial.toggle()
			}, label: {
				Text("앱 사용방법 보기")
			}
		)
		.tint(.primary)
		.fullScreenCover(isPresented: $isPresentedTutorial) {
			TutorialView()
		}
	}
	
	private func LockScreen() -> some View {
		HStack {
			Toggle("화면잠금 해제", isOn: $viewModel.isLockScreen)
				.tint(.ccTintColor)
		}
	}
	
	private func SkipTimeSelection() -> some View {
		Picker("건너뛰기 시간 설정", selection: $viewModel.skipTime) {
			ForEach(SkipTime.allCases, id: \.self) { time in
				Text("\(time.description) 초")
					.tag(time)
			}
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
			Link(
				destination: .init(
					string: "https://www.instagram.com/casualconversation_ccrecorder/")!,
				label: {
					Label("인스타그램 소통하기", systemImage: "hand.thumbsup")
				}
			)
			Button(
				action: {
					self.isShowingMailView.toggle()
				}, label: {
					Label("문의하기", systemImage: "envelope.open")
				}
			)
			.sheet(isPresented: $isShowingMailView) {
				MailView(
					isShowing: $isShowingMailView,
					result: $viewModel.mailSendedResult
				)
			}
			Button(
				action: {
					viewModel.requestReview()
				}, label: {
					Label("별점주기", systemImage: "star.leadinghalf.filled")
				}
			)
			Button(
				action: {
					self.isShowingActivityView.toggle()
				}, label: {
					Label("공유하기", systemImage: "square.and.arrow.up")
				}
			)
			.background {
				ActivityView(isPresented: $isShowingActivityView)
			}
		} header: {
			Text("소통")
		}
		.tint(.primary)
	}
	
	private func UnclassifiedSection() -> some View {
		Section {
//			NavigationLink(destination: {
//				Text("오픈소스 라이선스")
//			}, label: {
//				Text("오픈소스 라이선스")
//			})
			
			HStack {
				Text("버전")
				Spacer()
				Text(viewModel.version)
					.font(.subheadline)
					.foregroundColor(.gray)
			}
			
			NavigationLink(destination: {
				TeamMateInfoView()
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
		SettingView(viewModel: .init())
			.preferredColorScheme(.light)
		SettingView(viewModel: .init())
			.preferredColorScheme(.dark)
    }
	
}
