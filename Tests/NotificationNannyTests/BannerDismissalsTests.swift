import Testing
@testable import NotificationNannyCore

@Suite("Dismissed overlays stay dismissed") @MainActor
struct BannerDismissalsTests {
    /// The native close failed in the user's log. When the next message arrives,
    /// macOS still enumerates both banners in the shared host window.
    @Test func failedNativeClose_doesNotResurrectOldOverlayWhenNextBannerArrives() {
        let dismissals = BannerDismissals()
        var nativeCloseAttempts = 0

        let closed = dismissals.dismiss("old-message") {
            nativeCloseAttempts += 1
            return false
        }
        #expect(!closed) // Don't pretend the native notification was removed.
        #expect(nativeCloseAttempts == 1)

        let present = ["old-message", "new-message"]
        dismissals.prune(keeping: Set(present))
        let visible = present.filter { !dismissals.contains($0) }
        #expect(visible == ["new-message"])

        // Another layout event must not resurrect it either.
        dismissals.prune(keeping: Set(present))
        #expect(present.filter { !dismissals.contains($0) } == ["new-message"])
    }

    @Test func successfulNativeClose_hidesOverlayWhileNativeRemovalIsPending() {
        let dismissals = BannerDismissals()
        #expect(dismissals.dismiss("old-message") { true })
        #expect(dismissals.contains("old-message"))
        #expect(!dismissals.contains("new-message"))
    }

    @Test func dismissalIsRecordedBeforeNativeActionCanTriggerAnotherSweep() {
        let dismissals = BannerDismissals()
        dismissals.dismiss("old-message") {
            #expect(dismissals.contains("old-message"))
            return false
        }
        #expect(dismissals.contains("old-message"))
    }

    @Test func prune_releasesOnlyBannersNoLongerReportedByMacOS() {
        let dismissals = BannerDismissals()
        dismissals.dismiss("gone") { true }
        dismissals.dismiss("still-present") { true }
        dismissals.prune(keeping: ["still-present", "new-message"])

        #expect(!dismissals.contains("gone"))
        #expect(dismissals.contains("still-present"))
        #expect(!dismissals.contains("new-message"))
        dismissals.prune(keeping: [])
        #expect(dismissals.isEmpty)
    }
}
