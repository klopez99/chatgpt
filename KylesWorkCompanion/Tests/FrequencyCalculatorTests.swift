import Testing
@testable import KylesWorkCompanion

@Test func steppedFrequencyTotals() {
    #expect(FrequencyCalculator.scheduledTotal("2w3, then 1w3, then 0w1") == 9)
    #expect(FrequencyCalculator.prnTotal("2w3, 4 PRN") == 4)
}
