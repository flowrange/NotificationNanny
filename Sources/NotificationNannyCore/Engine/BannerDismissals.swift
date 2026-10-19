/// Keeps a dismissed overlay from being recreated while Notification Center
/// still reports its underlying banner. Closing the native banner is a separate
/// operation: Accessibility can reject it, or remove the banner asynchronously.
@MainActor
final class BannerDismissals {
    private var ids: Set<String> = []

    var isEmpty: Bool { ids.isEmpty }

    func contains(_ id: String) -> Bool { ids.contains(id) }

    @discardableResult
    func dismiss(_ id: String, closeNative: () -> Bool) -> Bool {
        // Record the user's intent before invoking Accessibility: the call may
        // fail, or trigger another layout event while the old banner is present.
        ids.insert(id)
        return closeNative()
    }

    func prune(keeping present: Set<String>) { ids.formIntersection(present) }

    func removeAll() { ids.removeAll() }
}
