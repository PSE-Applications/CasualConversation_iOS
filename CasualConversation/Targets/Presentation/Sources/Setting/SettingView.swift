//
//  SettingView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/08/09.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

struct SettingView: View {
	
    var body: some View {
		VStack {
			List {
				Section {
					
				} header: {
					Text("정보")
				}
				Section {
					
				} header: {
					Text("일반")
				}
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
			.listStyle(.grouped)
			
			Text("@2022. Team Marcoda. All rights reserved.")
				.foregroundColor(.gray)
				.font(.caption)
		}
		.navigationTitle("Setting")
    }
	
}

#if DEBUG

struct SettingView_Previews: PreviewProvider {
	
    static var previews: some View {
        SettingView()
    }
	
}

#endif
