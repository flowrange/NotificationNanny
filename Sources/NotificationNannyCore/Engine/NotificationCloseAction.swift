import Foundation

/// Resolves the exact action token returned by Accessibility. Passing that
/// token through unchanged matters for custom actions with Target/Selector data.
enum NotificationCloseAction {
    static func named(_ name: String, in available: [String]) -> String? {
        let accepted = localizedNames[name] ?? [name]
        return available.first { action in
            let label: String
            if action.hasPrefix("Name:"), let end = action.firstIndex(of: "\n") {
                label = String(action[action.index(action.startIndex, offsetBy: 5)..<end])
            } else {
                label = action
            }
            return accepted.contains(label)
        }
    }

    /// Use Notification Center's translations, rather than Nanny's UI language
    /// or a hand-maintained list. macOS exposes localized custom-action names.
    /// Loading all translations also handles a per-app language override.
    private static let localizedNames: [String: Set<String>] = {
        let keys = ["Close", "Clear All"]
        var names = Dictionary(uniqueKeysWithValues: keys.map { ($0, Set([$0])) })
        guard let bundle = Bundle(path: "/System/Library/CoreServices/NotificationCenter.app") else {
            return names
        }

        // Current macOS ships a combined localization table.
        if let url = bundle.resourceURL?.appendingPathComponent("Localizable.loctable"),
           let data = try? Data(contentsOf: url),
           let tables = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] {
            for case let table as [String: Any] in tables.values {
                for key in keys {
                    if let label = table[key] as? String, !label.isEmpty { names[key]?.insert(label) }
                }
            }
        }

        // Older releases use individual .lproj/Localizable.strings resources.
        for language in bundle.localizations {
            guard let path = bundle.path(forResource: language, ofType: "lproj"),
                  let localized = Bundle(path: path) else { continue }
            for key in keys {
                let label = localized.localizedString(forKey: key, value: key, table: "Localizable")
                if !label.isEmpty { names[key]?.insert(label) }
            }
        }
        return names
    }()
}
