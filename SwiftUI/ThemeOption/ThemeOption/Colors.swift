import SwiftUI

struct ColorToken {
    let backgroundPrimary: Color
    let backgroundSecondary: Color
    let textPrimary: Color
    let textSecondary: Color
    let divider: Color

    static func colors(
        themeOption: ThemeOption,
        systemColorScheme: ColorScheme
    ) -> ColorToken {
        let currentDisplayTheme = themeOption.displayTheme(systemColorScheme: systemColorScheme)
        return colors(currentDisplayTheme)
    }
    
    // color 1:1 매칭
    private static func colors(_ displayTheme: DisplayTheme) -> ColorToken {
        return switch displayTheme {
        case .light: lightModeColors
        case .dark: darkModeColors
        }
    }
    private static let lightModeColors = ColorToken(
        backgroundPrimary: Color(hex: "#FFFFFF"),
        backgroundSecondary: Color(hex: "#F2F2F7"),
        textPrimary: Color(hex: "#111111"),
        textSecondary: Color(hex: "#6B6B6B"),
        divider: Color(hex: "#E5E5EA")
    )
    private static let darkModeColors = ColorToken(
        backgroundPrimary: Color(hex: "#111111"),
        backgroundSecondary: Color(hex: "#1C1C1E"),
        textPrimary: Color(hex: "#FFFFFF"),
        textSecondary: Color(hex: "#A1A1A1"),
        divider: Color(hex: "#2C2C2E")
    )
}

// MARK: - DisplayTheme
// 현재 화면에 나타낼 테마
enum DisplayTheme {
    case light
    case dark
}

// MARK: - ThemeOption
// 선택 가능한 옵션
enum ThemeOption: String, CaseIterable {
    case system
    case fixedDark
    case fixedLight

    var titleText: LocalizedStringKey {
        switch self {
        case .system:
            return "시스템 모드"
        case .fixedLight:
            return "라이트 모드"
        case .fixedDark:
            return "다크 모드"
        }
    }

    func displayTheme(systemColorScheme: ColorScheme) -> DisplayTheme {
        return switch self {
        case .system: systemColorScheme == .dark ? .dark : .light
        case .fixedLight: .light
        case .fixedDark: .dark
        }
    }
}

// MARK: - Color+
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
