import SwiftUI
import SwiftData

@main
struct KylesWorkCompanionApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @State private var security = SecurityService()
    @State private var privacy = PrivacySettings()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environment(security)
                .environment(privacy)
                .modelContainer(AppModelContainer.shared)
                .privacyProtection()
                .task { await security.unlockIfNeeded() }
        }
        .onChange(of: scenePhase) { _, phase in
            security.handleScenePhase(phase)
        }
    }
}
