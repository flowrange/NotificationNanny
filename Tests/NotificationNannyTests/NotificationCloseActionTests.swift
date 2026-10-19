import Testing
@testable import NotificationNannyCore

@Suite("Native notification close actions")
struct NotificationCloseActionTests {
    // Captured from the real failing alert on French macOS, 2026-10-15.
    private let frenchAlertActions = [
        "AXPress",
        "Name:Afficher les détails\nTarget:0x0\nSelector:(null)",
        "Name:Fermer\nTarget:0x0\nSelector:(null)"
    ]

    @Test func frenchAlert_selectsItsActualCloseActionWithoutChangingTheToken() {
        #expect(NotificationCloseAction.named("Close", in: frenchAlertActions)
                == frenchAlertActions[2])
    }

    @Test func frenchStack_selectsClearAllRatherThanOpenOrReply() {
        // "Clear All" -> "Tout effacer" in Notification Center's own resources.
        let clear = "Name:Tout effacer\nTarget:0x0\nSelector:(null)"
        #expect(NotificationCloseAction.named("Clear All", in: ["AXPress", clear]) == clear)
        #expect(NotificationCloseAction.named("Close", in: ["AXPress", clear]) == nil)
    }

    @Test func englishActions_remainCompatible() {
        let close = "Name:Close\nTarget:0x0\nSelector:(null)"
        #expect(NotificationCloseAction.named("Close", in: ["AXPress", close]) == close)
        #expect(NotificationCloseAction.named("Clear All", in: ["Clear All"]) == "Clear All")
    }

    @Test func neverSubstitutesOpeningReplyingOrDeletingAMessage() {
        let unrelated = ["AXPress", "Name:Afficher les détails\nTarget:0x0\nSelector:(null)",
                         "Reply", "Supprimer", "Name:Close account\nTarget:0x0\nSelector:(null)"]
        #expect(NotificationCloseAction.named("Close", in: unrelated) == nil)
        #expect(NotificationCloseAction.named("Clear All", in: unrelated) == nil)
    }
}
