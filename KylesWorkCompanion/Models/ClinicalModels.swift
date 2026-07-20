import Foundation
import SwiftData

enum PlaceOfService: String, Codable, CaseIterable, Identifiable {
    case home = "Home", alf = "ALF", boardAndCare = "Board and care", other = "Other"
    var id: String { rawValue }
}

enum DocumentationStatus: String, Codable, CaseIterable {
    case notStarted = "Not started", draft = "Draft", complete = "Complete", locked = "Locked"
}

@Model
final class Patient {
    var id: UUID
    var displayName: String
    var initials: String
    var admissionDate: Date
    var placeOfService: PlaceOfService
    var primaryDiagnosis: String
    var secondaryDiagnoses: [String]
    var skilledNeeds: [String]
    var homeboundStatus: String
    var caregiverAvailability: String
    var currentSNFrequency: String
    var currentHHAFrequency: String
    var preauthorizedVisits: Int
    var prnVisitsUsed: Int
    var activeGoals: [CareGoal]
    var wounds: [Wound]
    var foleyInformation: String
    var labInformation: String
    var medicationConcerns: String
    var fallRisk: String
    var alerts: String
    var isArchived: Bool
    var visits: [Visit]

    init(displayName: String, initials: String, admissionDate: Date, placeOfService: PlaceOfService, primaryDiagnosis: String, secondaryDiagnoses: [String] = [], skilledNeeds: [String] = [], homeboundStatus: String = "", caregiverAvailability: String = "", currentSNFrequency: String = "", currentHHAFrequency: String = "", preauthorizedVisits: Int = 0, prnVisitsUsed: Int = 0, activeGoals: [CareGoal] = [], wounds: [Wound] = [], foleyInformation: String = "", labInformation: String = "", medicationConcerns: String = "", fallRisk: String = "", alerts: String = "", isArchived: Bool = false, visits: [Visit] = []) {
        self.id = UUID(); self.displayName = displayName; self.initials = initials; self.admissionDate = admissionDate; self.placeOfService = placeOfService; self.primaryDiagnosis = primaryDiagnosis; self.secondaryDiagnoses = secondaryDiagnoses; self.skilledNeeds = skilledNeeds; self.homeboundStatus = homeboundStatus; self.caregiverAvailability = caregiverAvailability; self.currentSNFrequency = currentSNFrequency; self.currentHHAFrequency = currentHHAFrequency; self.preauthorizedVisits = preauthorizedVisits; self.prnVisitsUsed = prnVisitsUsed; self.activeGoals = activeGoals; self.wounds = wounds; self.foleyInformation = foleyInformation; self.labInformation = labInformation; self.medicationConcerns = medicationConcerns; self.fallRisk = fallRisk; self.alerts = alerts; self.isArchived = isArchived; self.visits = visits
    }
}

@Model
final class Visit {
    var id: UUID
    var date: Date
    var visitType: String
    var plannedFrequency: String
    var location: String
    var isCompleted: Bool
    var documentationStatus: DocumentationStatus
    var sortOrder: Int
    init(date: Date, visitType: String, plannedFrequency: String, location: String, isCompleted: Bool = false, documentationStatus: DocumentationStatus = .notStarted, sortOrder: Int = 0) {
        self.id = UUID(); self.date = date; self.visitType = visitType; self.plannedFrequency = plannedFrequency; self.location = location; self.isCompleted = isCompleted; self.documentationStatus = documentationStatus; self.sortOrder = sortOrder
    }
}

@Model
final class CareGoal { var id: UUID; var title: String; var progress: String; var isActive: Bool
    init(title: String, progress: String = "", isActive: Bool = true) { self.id = UUID(); self.title = title; self.progress = progress; self.isActive = isActive }
}

@Model
final class Wound { var id: UUID; var woundNumber: Int; var location: String; var etiology: String; var stage: String; var length: Double; var width: Double; var depth: Double; var assessmentDate: Date; var photoFilename: String?
    init(woundNumber: Int, location: String, etiology: String, stage: String = "", length: Double = 0, width: Double = 0, depth: Double = 0, assessmentDate: Date = .now, photoFilename: String? = nil) { self.id = UUID(); self.woundNumber = woundNumber; self.location = location; self.etiology = etiology; self.stage = stage; self.length = length; self.width = width; self.depth = depth; self.assessmentDate = assessmentDate; self.photoFilename = photoFilename }
}
