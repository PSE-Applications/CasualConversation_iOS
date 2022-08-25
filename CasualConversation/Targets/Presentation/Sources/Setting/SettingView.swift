//
//  SettingView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/08/09.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

struct SettingView: View {
	
	@Environment(\.colorScheme) var colorScheme
	
	@ObservedObject var viewModel: SettingViewModel
	
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
			
			Text("@2022. Team Marcoda. All rights reserved.")
				.foregroundColor(.gray)
				.font(.caption)
		}
		.navigationTitle("Setting")
		.navigationBarTitleDisplayMode(.inline)
		.background(self.colorScheme == .dark ? .recordBackground : Color.clear)
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
					Image(colorScheme == .dark ? "pse_logo_border" : "pse_logo")
						.resizable()
						.frame(width: 40, height: 40)
					Text("What is Casual Conversation?")
						.font(.headline)
				}
			}
		)
	}
	
	@ViewBuilder
	private func AcademyInfo() -> some View {
		VStack(alignment: .center) {
			Image(colorScheme == .dark ? "pse_title_border" : "pse_title")
				.resizable()
				.frame(height: 100)
			Text("프린서플어학원 CC Time 프로그램")
				.font(.headline)
		}
		VStack(alignment: .leading) {
			Text("언제 어디서나 영어회화로 가벼운 인사부터 다양한 주제의 대화를 나누는 영어회화 학습방법입니다.")
				.font(.subheadline)
			Text("Topics 및 발음기호 등 관련 정보는 PSE에서 제공합니다.")
				.font(.caption)
				.foregroundColor(.gray)
		}
		.lineLimit(nil)
		.fixedSize(horizontal: false, vertical: true)
	}
	
	@ViewBuilder
	private func AcademyPages() -> some View {
		Group {
			Link("🔍 프린서플어학원 알아보기",
				 destination: URL(string: "https://pseenglish.modoo.at")!
			)
			Link("☕️ 네이버카페",
				 destination: URL(string: "https://m.cafe.naver.com/ca-fe/psecafe")!
			)
			Link("🖥 e-Learning",
				 destination: URL(string: "http://pse-learning.site/de/board.php?board=home")!
			)
			Link("👀 정규반 맛보기 강의",
				 destination: URL(string: "https://pseenglish.modoo.at/?link=e8gh4487")!
			)
			Link("📄 온라인 레벨테스트",
				 destination: URL(string: "https://pseenglish.modoo.at/?link=dc89m2n4")!
			)
			Button("📞 문의전화") {
				let phone = "tel://"
				let phoneNumber = "02-539-8963"
				let url = URL(string: phone + phoneNumber)!
				UIApplication.shared.open(url)
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
				.tint(self.colorScheme == .dark ? .logoDarkGreen : .logoLightGreen)
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
		HStack {
			Text("다크모드")
			Spacer()
			Picker("DarkMode", selection: $viewModel.darkMode) {
				ForEach(SettingViewModel.ColorScheme.allCases, id: \.self) { condition in
					Text(condition.description)
						.tag(condition)
				}
			}
			.frame(width: 200)
			.pickerStyle(.segmented)
			.onAppear {
				UISegmentedControl.appearance().selectedSegmentTintColor = UIColor
					.init(self.colorScheme == .dark ? .logoDarkGreen : .logoLightGreen)
			}
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
