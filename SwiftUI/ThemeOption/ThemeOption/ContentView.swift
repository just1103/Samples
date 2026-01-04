import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var systemColorScheme 
    @StateObject var viewModel: ContentViewModel

    private var displayTheme: DisplayTheme {
        return switch viewModel.selectedTheme {
        case .system: systemColorScheme == .dark ? .dark : .light
        case .fixedLight: .light
        case .fixedDark: .dark
        }
    }

    private var colors: ColorToken {
        ColorToken.theme(displayTheme)
    }
    
    private var preferredColorScheme: ColorScheme? {
        viewModel.preferredColorScheme
    }

    var body: some View {
        List {
            HStack(spacing: 0) {
                Image(systemName: "moon.fill")
                    .foregroundStyle(colors.textPrimary)

                Text("화면 모드")
                    .foregroundStyle(colors.textPrimary)
                    .padding(.leading, 14)

                Spacer(minLength: 0)

                Picker("", selection: $viewModel.selectedTheme) {
                    ForEach(ThemeOption.allCases, id: \.self) { option in
                        Text(option.titleText)
                            .foregroundStyle(colors.textPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .pickerStyle(.menu)
            }
            .listRowBackground(colors.backgroundPrimary)
        }
        .preferredColorScheme(preferredColorScheme) // viewModel.preferredColorScheme 바로 할당 불가
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
