import SwiftUI
import SwiftData

struct PatientListView: View {
    @Environment(PrivacySettings.self) private var privacy
    @Query(filter: #Predicate<Patient> { !$0.isArchived }, sort: \Patient.displayName) private var patients: [Patient]
    var body: some View {
        List(patients) { patient in NavigationLink { PatientDashboardView(patient: patient) } label: { PatientCard(patient: patient, privacyMode: privacy.privacyModeEnabled) } }
            .navigationTitle("Patients")
            .toolbar { Toggle(isOn: Bindable(privacy).privacyModeEnabled) { Label("Privacy", systemImage: "eye.slash") } }
            .overlay { if patients.isEmpty { EmptyStateView(title: "No patients", message: "Add fictional preview data or create a patient record.") } }
    }
}

struct PatientCard: View { let patient: Patient; let privacyMode: Bool; var body: some View { VStack(alignment: .leading) { Text(privacyMode ? patient.initials : patient.displayName).font(.headline); Text(patient.primaryDiagnosis).font(.subheadline); HStack { StatusBadge(text: patient.placeOfService.rawValue, systemImage: "house"); StatusBadge(text: patient.currentSNFrequency.isEmpty ? "No SN freq" : patient.currentSNFrequency, systemImage: "calendar.badge.clock") } } } }

struct PatientDashboardView: View {
    @Bindable var patient: Patient
    var body: some View {
        List {
            ClinicalSection(title: "Current clinical status") { Text(patient.alerts.isEmpty ? "No current alerts entered." : patient.alerts) }
            ClinicalSection(title: "Active skilled needs") { ForEach(patient.skilledNeeds, id: \.self) { Text($0) } }
            ClinicalSection(title: "Current authorization period") { Text("SN: \(patient.currentSNFrequency)  HHA: \(patient.currentHHAFrequency)"); Text("Remaining visits: \(max(patient.preauthorizedVisits - patient.visits.filter(\.isCompleted).count, 0))") }
            ClinicalSection(title: "Recent visit notes") { ForEach(patient.visits.prefix(3)) { Text("\($0.visitType): \($0.documentationStatus.rawValue)") } }
            ClinicalSection(title: "Active wounds") { ForEach(patient.wounds) { Text("#\($0.woundNumber) \($0.location) — \($0.length, specifier: "%.1f") x \($0.width, specifier: "%.1f") x \($0.depth, specifier: "%.1f") cm") } }
            ClinicalSection(title: "Active goals") { ForEach(patient.activeGoals) { Text($0.title) } }
            ClinicalSection(title: "Upcoming tasks") { Text("Review visit plan and documentation status.") }
            ClinicalSection(title: "Quick actions") { QuickActionGrid() }
        }.navigationTitle(patient.displayName)
    }
}

struct QuickActionGrid: View { let actions = ["New skilled nursing note", "New Get Auth", "New subsequent authorization request", "New wound assessment", "New physician order", "Create visit summary", "Copy patient summary"]; var body: some View { ForEach(actions, id: \.self) { Button($0) { } } } }
