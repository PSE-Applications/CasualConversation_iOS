//
//  TargetDependency+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by Yongwoo Marco on 2022/07/02.
//

import ProjectDescription

public extension TargetDependency {
//	static let swinject = TargetDependency.package(product: "Swinject")
//	static let swinjectAutoregistration =  TargetDependency.package(product: "SwinjectAutoregistration")
	static let quick: TargetDependency = .package(product: "Quick")
	static let nimble: TargetDependency = .package(product: "Nimble")
}

public extension Package {
//	static let swinject = Package.remote(
//		url: "https://github.com/Swinject/Swinject.git",
//		requirement: .upToNextMajor(from: .init(2, 8, 1))
//	)
//	static let swinjectAutoregistration = Package.remote(
//		url: "https://github.com/Swinject/SwinjectAutoregistration.git",
	//		requirement: .upToNextMajor(from: .init(2, 8, 1)))
	static let quick = Package.remote(
		url: "https://github.com/Quick/Quick.git",
		requirement: .upToNextMajor(from: .init(3, 0, 0)))
	static let nimble = Package.remote(
		url: "https://github.com/Quick/Nimble.git",
		requirement: .upToNextMajor(from: .init(9, 0, 0)))
}

// MARK: - SourceFile
public extension SourceFilesList {
	static let sources: SourceFilesList = "Sources/**"
	static let tests: SourceFilesList = "Tests/**"
}

// MARK: - Resource
public enum ResourceType: String {
	case xibs = "Sources/**/*.xib"
	case storyboards = "Resources/**/*.storyboard"
	case assets = "Resources/**"
}

// MARK: - Extension
public extension Array where Element == FileElement {
	static func resources(with resources: [ResourceType]) -> [FileElement] {
		resources.map { FileElement(stringLiteral: $0.rawValue) }
	}
}
