import SwiftUI

final class ContentViewModel: ObservableObject {
    private let userDefaultsManager = UserDefaultsManager.shared

    @Published var selectedTheme: ThemeOption = .system {
        didSet {
            userDefaultsManager.save(selectedTheme.rawValue, forKey: .theme)
        }
    }
    
    var preferredColorScheme: ColorScheme? {
        return switch selectedTheme {
        case .system: nil
        case .fixedLight: .light
        case .fixedDark: .dark
        }
    }
    
    func colors(systemColorScheme: ColorScheme) -> ColorToken {
        let displayTheme: DisplayTheme = {
            return switch selectedTheme {
            case .system: systemColorScheme == .dark ? .dark : .light
            case .fixedLight: .light
            case .fixedDark: .dark
            }
        }()
        return ColorToken.theme(displayTheme)
    }

    init() {
        let savedTheme = userDefaultsManager.theme
        selectedTheme = ThemeOption(rawValue: savedTheme) ?? .system

        if savedTheme.isEmpty {
            userDefaultsManager.save(ThemeOption.system.rawValue, forKey: .theme)
        }
    }
}

final class UserDefaultsManager: ObservableObject {
    enum Key: String {
        case theme
    }

    @AppStorage(Key.theme.rawValue) private(set) var theme: String = ""

    var isFixedLightMode: Bool {
        theme == ThemeOption.fixedLight.rawValue
    }

    var isFixedDarkMode: Bool {
        theme == ThemeOption.fixedDark.rawValue
    }

    var isSystemMode: Bool {
        theme == ThemeOption.system.rawValue
    }

    func save(_ value: Any?, forKey key: Key) {
        switch key {
        case .theme:
            guard let value = value as? String else {
                return
            }
            theme = value
        }
    }

    static let shared = UserDefaultsManager()
    private init() {}
}
