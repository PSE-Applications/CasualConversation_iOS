import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

enum PSE {
	static let projectName = "CasualConversation"
	static let organizationName = "pseapplications"
	static let bundleId = "com.pseapplications"
	static let deploymentTarget = DeploymentTarget
		.iOS(targetVersion: "15.0", devices: [.iphone, .ipad])
}

// MARK: - Modules
enum CleanArchitecture {
	case common
	case presentation
	case domain
	case data
	
	var name: String {
		switch self {
		case .common: 		return "Common"
		case .presentation: return "Presentation"
		case .domain: 		return "Domain"
		case .data:			return "Data"
		}
	}
}

func makeModule(layer: CleanArchitecture, dependencies: [CleanArchitecture]) -> [Target] {
	let sources = Target(
		name: "\(layer.name)",
		platform: .iOS,
		product: .framework,
		productName: nil,
		bundleId: "\(PSE.bundleId).\(layer.name)",
		deploymentTarget: PSE.deploymentTarget,
//		infoPlist: .default,
		sources: ["Targets/\(layer.name)/Sources/**"],
		resources: nil,
		copyFiles: nil,
		headers: nil,
		entitlements: nil,
		scripts: [],
		dependencies: dependencies.map { .target(name: $0.name) },
		settings: nil,
		coreDataModels: [],
		environment: [:],
		launchArguments: [],
		additionalFiles: []
	)
	let tests = Target(
		name: "\(layer.name)Tests",
		platform: .iOS,
		product: .unitTests,
		bundleId: "\(PSE.bundleId).DomainTests",
//		infoPlist: .default,
		sources: ["Targets/\(layer.name)/Tests/**"],
		resources: [],
		dependencies: [
			.target(name: "\(layer.name)")
		]
	)
	return [sources, tests]
}

let commonModule = makeModule(layer: .common, dependencies: [])
let presentationModule = makeModule(layer: .presentation, dependencies: [.common, .domain])
let dataModule = makeModule(layer: .data, dependencies: [.common, .domain])
let domainModule = makeModule(layer: .domain, dependencies: [.common])



// MARK: - Project
let infoPlist: [String: InfoPlist.Value] = [
	"CFBundleShortVersionString": "1.0",
	"CFBundleVersion": "1",
	"UIMainStoryboardFile": "",
	"UISupportedInterfaceOrientations" : ["UIInterfaceOrientationPortrait"],
	"UILaunchStoryboardName": "LaunchScreen"
]

let mainAppTarget = [
	Target(
	name: PSE.projectName,
	platform: .iOS,
	product: .app,
	productName: nil,
	bundleId: "\(PSE.bundleId).\(PSE.projectName)",
	deploymentTarget: PSE.deploymentTarget,
	infoPlist: .extendingDefault(with: infoPlist),
	sources: ["Targets/\(PSE.projectName)/Sources/**"],
	resources: ["Targets/\(PSE.projectName)/Resources/**"],
	copyFiles: nil,
	headers: nil,
	entitlements: nil,
	scripts: [],
	dependencies: [
		.target(name: CleanArchitecture.common.name),
		.target(name: CleanArchitecture.presentation.name),
		.target(name: CleanArchitecture.domain.name),
		.target(name: CleanArchitecture.data.name)//,
//		.swinject,
//		.swinjectAutoregistration
	],
	settings: nil,
	coreDataModels: [],
	environment: [:],
	launchArguments: [],
	additionalFiles: []),
	Target(
		name: "\(PSE.projectName)Tests",
		platform: .iOS,
		product: .unitTests,
		productName: nil,
		bundleId: "\(PSE.bundleId).\(PSE.projectName)Tests",
		deploymentTarget: PSE.deploymentTarget,
//		infoPlist: .default,
		sources: ["Targets/\(PSE.projectName)/Tests/**"],
		resources: nil,
		copyFiles: nil,
		headers: nil,
		entitlements: nil,
		scripts: [],
		dependencies: [
			.target(name: PSE.projectName)
		],
		settings: nil,
		coreDataModels: [],
		environment: [:],
		launchArguments: [],
		additionalFiles: []
	)
]

let project = Project
	.init(
		name: PSE.projectName,
		organizationName: PSE.organizationName,
		// options
		packages: [
//			.swinject,
//			.swinjectAutoregistration
		],
		settings: .settings(configurations: [
			.debug(name: "Debug"),
			.release(name: "Release")
		]),
		targets: [
			mainAppTarget,
			commonModule,
			presentationModule,
			domainModule,
			dataModule,
		].flatMap { $0 },
		schemes: [],
		fileHeaderTemplate: nil,
		additionalFiles: [],
		resourceSynthesizers: []
	)
