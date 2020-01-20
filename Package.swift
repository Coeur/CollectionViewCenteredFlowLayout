// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "CollectionViewCenteredFlowLayout",
    products: [
        .library(name: "CollectionViewCenteredFlowLayout", targets: ["CollectionViewCenteredFlowLayout"])
    ],    
    targets: [
        .target(
            name: "CollectionViewCenteredFlowLayout",
            path: "CollectionViewCenteredFlowLayout"
        )
    ],
    swiftLanguageVersions: [.v5]
)
