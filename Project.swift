import ProjectDescription

let project = Project(
    name: "DeliveryFood",
    targets: [
        .target(
            name: "DeliveryFood",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.DeliveryFood",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["DeliveryFood/Sources/**"],
            resources: ["DeliveryFood/Resources/**"],
            dependencies: [
                .target(name: "Navigation"),
                .target(name: "Map"),
                .target(name: "Catalog")
            ]
        ),
        .target(
            name: "DeliveryFoodTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.DeliveryFoodTests",
            infoPlist: .default,
            sources: ["DeliveryFood/Tests/**"],
            resources: [],
            dependencies: [.target(name: "DeliveryFood")]
        ),
        //Flows
        .target(
            name: "Map",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.Map",
            infoPlist: .default,
            sources: ["DeliveryFood/Flows/Map/**"],
            resources: [],
            dependencies: [
                .target(name: "Navigation"),
                .target(name: "DesignSystem"),
                .target(name: "Core")
            ]
        ),
        .target(
            name: "Catalog",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.Catalog",
            infoPlist: .default,
            sources: ["DeliveryFood/Flows/Catalog/**"],
            resources: [],
            dependencies: [
                .target(name: "Navigation"),
                .target(name: "DesignSystem"),
                .target(name: "Core")
            ]
        ),
        //Packages
        .target(
            name: "Navigation",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.Navigation",
            infoPlist: .default,
            sources: ["DeliveryFood/Packages/Navigation/**"],
            resources: [],
            dependencies: []
        ),
        .target(
            name: "Core",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.Core",
            infoPlist: .default,
            sources: ["DeliveryFood/Packages/Core/**"],
            resources: [],
            dependencies: []
        ),
        .target(
            name: "DesignSystem",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.DesignSystem",
            infoPlist: .default,
            sources: ["DeliveryFood/Packages/DesignSystem/**"],
            resources: [],
            dependencies: []
        ),
    ]
)
