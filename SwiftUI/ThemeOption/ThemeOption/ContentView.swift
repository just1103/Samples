import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel
    
    var body: some View {
        List {
            HStack(spacing: 0) {
                Image(systemName: "moon.fill")

                Text("화면 모드")
                    .foregroundStyle(Color.color111111)
                    .padding(.leading, 14)

                Spacer(minLength: 0)

                Picker("", selection: $viewModel.selectedTheme) {
                    ForEach(ThemeOption.allCases, id: \.self) { option in
                        Text(option.titleText)
                            .foregroundStyle(Color.color111111)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .pickerStyle(.menu)
            }
        }
    }
}

class ContentViewModel: ObservableObject {
    @Published var selectedTheme: ThemeOption = .system
}

enum ThemeOption: String, CaseIterable {
    case system
    case fixedLight
    case fixedDark
    
    var titleText: LocalizedStringKey {
        return switch self {
        case .system:
            "시스템 모드"
        case .fixedLight:
            "라이트 모드"
        case .fixedDark:
            "다크 모드"
        }
    }
}

extension Color {
    static var color111111: Color { Color(hex: "#111111") } // black
    static var colorFFFFFF: Color { Color(hex: "#FFFFFF") } // white
    
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

#Preview {
    ContentView(
        viewModel: ContentViewModel()
    )
}
