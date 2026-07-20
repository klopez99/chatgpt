import Foundation
import SwiftData

enum AppModelContainer {
    static let shared: ModelContainer = {
        let schema = Schema([Patient.self, Visit.self, CareGoal.self, Wound.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do { return try ModelContainer(for: schema, configurations: [configuration]) }
        catch { fatalError("Unable to create local SwiftData store") }
    }()

    @MainActor static func preview() -> ModelContainer {
        let schema = Schema([Patient.self, Visit.self, CareGoal.self, Wound.self])
        let container = try! ModelContainer(for: schema, configurations: [ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)])
        SampleData.insert(into: container.mainContext)
        return container
    }
}
