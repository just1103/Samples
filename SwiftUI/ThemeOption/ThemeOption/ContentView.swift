import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var systemColorScheme 
    @StateObject var viewModel: ContentViewModel

    private var colors: ColorToken {
        viewModel.colors(systemColorScheme: systemColorScheme)
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
        .preferredColorScheme(viewModel.preferredColorScheme) // system dynamic color를 사용중이라면 필요함
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
