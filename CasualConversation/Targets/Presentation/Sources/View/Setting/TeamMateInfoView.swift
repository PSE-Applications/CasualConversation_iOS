//
//  TeamMateInfoView.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/29.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

struct TeamMateInfoView: View {
	
	struct TeamMate {
		let imageName: String
		let name: String
		let role: String
		let links: [(title: String, url: String)]
	}
	
    var body: some View {
		VStack {
			MemberInfo(by: .init(
					imageName: "profile_marco",
					name: "Marco",
					role: "Team Leader\niOS Development",
					links: [
						("github", "https://github.com/keeplo"),
						("blog", "https://keeplo.tistory.com"),
						("AppStore", "https://apps.apple.com/kr/developer/id1642134370")
					]
				)
			)
			MemberInfo(by: .init(
					imageName: "profile_coda",
					name: "Coda",
					role: "Project Management",
					links: [
						("github", "https://github.com/dacodaco"),
						("blog", "https://codable.space"),
						("AppStore", "https://apps.apple.com/kr/developer/id1604589992")
					]
				)
			)
			Spacer()
		}
		.navigationTitle("Team Marcoda")
    }
}

extension TeamMateInfoView {
	
	func MemberInfo(by member: TeamMate) -> some View {
		GroupBox {
			HStack {
				Image(member.imageName)
					.resizable()
					.frame(width: 100, height: 100)
					.mask(Circle())
					.padding()
				VStack(alignment: .leading) {
					Text(member.name)
						.font(.headline)
					Text(member.role)
						.font(.subheadline)
					HStack {
						ForEach(member.links, id: \.0) { link in
							Link(link.title, destination: .init(string: link.url)!)
								.font(.caption)
						}
					}
				}
				Spacer()
			}
		}
		.padding([.leading, .trailing])
	}
	
}

struct TeamMateInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TeamMateInfoView()
    }
}
