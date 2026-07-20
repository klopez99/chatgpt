import Foundation
import SwiftData

enum SampleData {
    @MainActor static func insert(into context: ModelContext) {
        let patients = [
            Patient(displayName: "Fictional ALF Foley Patient", initials: "FA", admissionDate: .now.addingTimeInterval(-86400*20), placeOfService: .alf, primaryDiagnosis: "Urinary retention", skilledNeeds: ["Chronic Foley catheter assessment", "Infection prevention teaching"], homeboundStatus: "Requires assistance to leave ALF.", caregiverAvailability: "ALF staff available; teachability varies by shift.", currentSNFrequency: "1w6", foleyInformation: "Chronic indwelling catheter with monthly change orders.", fallRisk: "Moderate"),
            Patient(displayName: "Fictional Edema Wrap Patient", initials: "EW", admissionDate: .now.addingTimeInterval(-86400*14), placeOfService: .home, primaryDiagnosis: "Bilateral lower extremity edema", skilledNeeds: ["Compression wrap application", "Skin integrity monitoring"], currentSNFrequency: "2w3, then 1w3"),
            Patient(displayName: "Fictional Diabetic Heel Wound", initials: "DH", admissionDate: .now.addingTimeInterval(-86400*7), placeOfService: .home, primaryDiagnosis: "Diabetic heel ulcer", skilledNeeds: ["Wound assessment", "Caregiver wound-care teaching"], wounds: [Wound(woundNumber: 1, location: "Left heel", etiology: "Diabetic", length: 2.4, width: 1.8, depth: 0.2)]),
            Patient(displayName: "Fictional Oxygen COPD Patient", initials: "OC", admissionDate: .now.addingTimeInterval(-86400*30), placeOfService: .home, primaryDiagnosis: "COPD with oxygen dependence", skilledNeeds: ["Respiratory assessment", "Oxygen safety teaching"], currentSNFrequency: "1w6"),
            Patient(displayName: "Fictional Bedbound HHA Patient", initials: "BH", admissionDate: .now.addingTimeInterval(-86400*10), placeOfService: .home, primaryDiagnosis: "Generalized weakness", skilledNeeds: ["Skin surveillance", "HHA supervision"], currentHHAFrequency: "3w4")
        ]
        for (index, patient) in patients.enumerated() {
            patient.visits = [Visit(date: .now, visitType: "SN visit", plannedFrequency: patient.currentSNFrequency.isEmpty ? patient.currentHHAFrequency : patient.currentSNFrequency, location: patient.placeOfService.rawValue, sortOrder: index)]
            context.insert(patient)
        }
    }
}
