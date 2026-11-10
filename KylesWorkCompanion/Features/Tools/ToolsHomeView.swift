import SwiftUI

struct ToolsHomeView: View {
    @State private var frequency = "2w3, then 1w3, then 0w1, 4 PRN"

    var body: some View {
        Form {
            Section("Frequency calculator") {
                TextField("Frequency", text: $frequency)
                Text("Scheduled visit total: \(FrequencyCalculator.scheduledTotal(frequency))")
                Text("PRN visit total: \(FrequencyCalculator.prnTotal(frequency))")
            }
            Section("California Medicare claims review") {
                Text("For eligible Original Medicare fee-for-service periods starting January 18, 2027 or later at a California agency billing J6, verify the billing period start and review path with billing. Medicare Advantage follows plan authorization. Use the usual care and documentation workflow.")
                if let source = URL(string: "https://www.cms.gov/data-research/monitoring-programs/medicare-fee-service-compliance-programs/prior-authorization-and-pre-claim-review-initiatives/review-choice-demonstration-home-health-services") {
                    Link("CMS California rollout", destination: source)
                }
            }
            Section("Privacy notice") {
                Text("No analytics, advertising SDK, third-party crash reporting, cloud AI, or external patient-data APIs are included.")
            }
        }
        .navigationTitle("Tools")
    }
}
