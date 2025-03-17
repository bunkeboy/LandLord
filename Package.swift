// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "LandLord",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "LandLord",
            targets: ["LandLord"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "11.9.0"),
    ],
    targets: [
        .target(
            name: "LandLord",
            dependencies: [
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseAuthCombine-Community", package: "firebase-ios-sdk"),
                .product(name: "FirebaseCore", package: "firebase-ios-sdk"),
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
            ]),
        .testTarget(
            name: "LandLordTests",
            dependencies: ["LandLord"]),
    ]
) 