import Foundation

enum FrequencyCalculator {
    static func scheduledTotal(_ text: String) -> Int {
        tokens(text).reduce(0) { total, token in
            let lower = token.lowercased().replacingOccurrences(of: " ", with: "")
            guard let wIndex = lower.firstIndex(of: "w") else { return total }
            let visits = Int(lower[..<wIndex]) ?? 0
            let weeks = Int(lower[lower.index(after: wIndex)...].prefix { $0.isNumber }) ?? 0
            return total + visits * weeks
        }
    }
    static func prnTotal(_ text: String) -> Int {
        tokens(text).reduce(0) { total, token in
            token.localizedCaseInsensitiveContains("PRN") ? total + (Int(token.prefix { $0.isNumber }) ?? 0) : total
        }
    }
    private static func tokens(_ text: String) -> [String] { text.replacingOccurrences(of: "then", with: ",").split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) } }
}
