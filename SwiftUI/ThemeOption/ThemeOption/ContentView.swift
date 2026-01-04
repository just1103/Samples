import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var systemColorScheme
    
//    @StateObject private var viewModel: ContentViewModel // 앱 최상위에서 ThemeStore 들고 있도록 개선
    @EnvironmentObject private var themeStore: ThemeStore

    private var colors: ColorToken {
        ColorToken.colors(
            themeOption: themeStore.selectedTheme,
            systemColorScheme: systemColorScheme
        )
    }

    var body: some View {
        List {
            HStack(spacing: 0) {
                Image(systemName: "moon.fill")
                    .foregroundStyle(colors.textPrimary)

                Text("테마")
                    .foregroundStyle(colors.textPrimary)
                    .padding(.leading, 14)

                Spacer(minLength: 0)

                Picker("", selection: $themeStore.selectedTheme) {
                    ForEach(ThemeOption.allCases, id: \.self) { option in
                        Text(option.titleText)
                            .foregroundStyle(colors.textPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .pickerStyle(.menu)
            }
        }
        .listRowBackground(colors.backgroundPrimary)
//        .preferredColorScheme(viewModel.preferredColorScheme) // system dynamic color를 사용중이면 필요함 -> 상위 뷰에서 설정
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeStore())
}
