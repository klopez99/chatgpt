import SwiftUI
import Observation
import LocalAuthentication

@Observable
final class SecurityService {
    var isUnlocked = false
    var hidesSwitcherContent = true
    var inactivityMinutes = 5
    private var backgroundedAt: Date?

    @MainActor func unlockIfNeeded() async {
        guard !isUnlocked else { return }
        let context = LAContext()
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else { isUnlocked = true; return }
        do { isUnlocked = try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Unlock Kyle’s Work Companion") }
        catch { isUnlocked = false }
    }

    func handleScenePhase(_ phase: ScenePhase) {
        if phase == .background { backgroundedAt = .now }
        if phase == .active, let backgroundedAt, Date().timeIntervalSince(backgroundedAt) > Double(inactivityMinutes * 60) { isUnlocked = false }
    }
}

@Observable
final class PrivacySettings { var privacyModeEnabled = false; var allowICDCodes = false }

struct PrivacyProtectionModifier: ViewModifier {
    @Environment(SecurityService.self) private var security
    func body(content: Content) -> some View {
        ZStack { content; if !security.isUnlocked { Color(.systemBackground).overlay(Label("Locked", systemImage: "lock.fill").font(.title)) } }
    }
}
extension View { func privacyProtection() -> some View { modifier(PrivacyProtectionModifier()) } }
