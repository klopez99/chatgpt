// swift-tools-version: 6.0
import PackageDescription
let package = Package(name: "KylesWorkCompanion", platforms: [.iOS(.v18)], products: [.library(name: "KylesWorkCompanion", targets: ["KylesWorkCompanion"])], targets: [.target(name: "KylesWorkCompanion", path: ".", exclude: ["Tests", "Package.swift", "README.md"], sources: ["App", "Models", "Persistence", "Features", "Services", "Components", "Utilities"]), .testTarget(name: "KylesWorkCompanionTests", dependencies: ["KylesWorkCompanion"], path: "Tests")])
