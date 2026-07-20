import SwiftUI
import SwiftData

struct TodayView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Patient.displayName) private var patients: [Patient]
    @State private var editMode: EditMode = .inactive
    private var todayVisits: [(Patient, Visit)] { patients.flatMap { patient in patient.visits.map { (patient, $0) } }.sorted { $0.1.sortOrder < $1.1.sortOrder } }
    private var unfinishedCount: Int { todayVisits.filter { $0.1.documentationStatus != .complete }.count }

    var body: some View {
        List {
            Section { VStack(alignment: .leading, spacing: 8) { Text(Date.now, style: .date).font(.largeTitle.bold()); Text("Daily visit count: \(todayVisits.count)"); if unfinishedCount > 0 { Label("\(unfinishedCount) unfinished documentation item(s)", systemImage: "exclamationmark.triangle").foregroundStyle(.orange) } } }
            Section("Scheduled patient visits") {
                ForEach(todayVisits, id: \.1.id) { patient, visit in TodayVisitRow(patient: patient, visit: visit) }
                    .onMove { source, destination in reorder(source: source, destination: destination) }
            }
        }
        .navigationTitle("Today")
        .toolbar { EditButton() }
        .environment(\.editMode, $editMode)
        .task { seedIfNeeded() }
    }

    private func reorder(source: IndexSet, destination: Int) { }
    @MainActor private func seedIfNeeded() { if patients.isEmpty { SampleData.insert(into: modelContext) } }
}

struct TodayVisitRow: View {
    @Environment(PrivacySettings.self) private var privacy
    @Bindable var patient: Patient
    @Bindable var visit: Visit
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack { Text(privacy.privacyModeEnabled ? patient.initials : patient.displayName).font(.headline); Spacer(); Toggle("Completed", isOn: $visit.isCompleted).labelsHidden() }
            Text("\(visit.visitType) • \(visit.plannedFrequency) • \(visit.location)").font(.subheadline)
            HStack { StatusBadge(text: visit.isCompleted ? "Complete" : "Open", systemImage: visit.isCompleted ? "checkmark.circle" : "circle"); StatusBadge(text: visit.documentationStatus.rawValue, systemImage: "doc.text") }
            HStack { Button("Start Visit") { }; Button("Open Patient") { }; Button("Create Note") { visit.documentationStatus = .draft } }.buttonStyle(.bordered)
        }.padding(.vertical, 6)
    }
}
