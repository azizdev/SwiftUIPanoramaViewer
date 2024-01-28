// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIPanoramaViewer",
    platforms: [.iOS(.v15), .tvOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftUIPanoramaViewer",
            targets: ["SwiftUIPanoramaViewer"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/martinmaly21/LogManager", .revision("43246309d90d7754a5e9afec82eed5fa4eeb1a1d")),
        .package(url: "https://github.com/martinmaly21/SwiftletUtilities", .revision("36b64e715a46117abb05f04ee32b5d6045b726ec")),
        .package(url: "https://github.com/martinmaly21/SoundManager", .revision("9b0100240d5364b545c1be3f610987de200f4780")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftUIPanoramaViewer",
            dependencies: ["LogManager", "SwiftletUtilities", "SoundManager"],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "SwiftUIPanoramaViewerTests",
            dependencies: ["SwiftUIPanoramaViewer"]),
    ]
)
