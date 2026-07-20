import SwiftUI

struct RootTabView: View {
    @State private var todayPath = NavigationPath()
    @State private var patientsPath = NavigationPath()
    @State private var documentationPath = NavigationPath()
    @State private var toolsPath = NavigationPath()
    @State private var settingsPath = NavigationPath()

    var body: some View {
        TabView {
            NavigationStack(path: $todayPath) { TodayView() }
                .tabItem { Label("Today", systemImage: "calendar") }
            NavigationStack(path: $patientsPath) { PatientListView() }
                .tabItem { Label("Patients", systemImage: "person.2") }
            NavigationStack(path: $documentationPath) { DocumentationHomeView() }
                .tabItem { Label("Documentation", systemImage: "doc.text") }
            NavigationStack(path: $toolsPath) { ToolsHomeView() }
                .tabItem { Label("Tools", systemImage: "wrench.and.screwdriver") }
            NavigationStack(path: $settingsPath) { SettingsView() }
                .tabItem { Label("Settings", systemImage: "gearshape") }
        }
    }
}
