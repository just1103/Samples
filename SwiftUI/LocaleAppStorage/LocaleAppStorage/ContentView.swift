//
//  ContentView.swift
//  LocaleAppStorage
//
//  Created by Hyoju Son on 12/28/25.
//

import SwiftUI

/*
 - 앱을 최초 실행할 때, 시스템 설정의 preferred language를 가져와서 기본값으로 설정 및 로컬에 저장
 - picker에서 선택한 언어 옵션을 로컬에 저장 (UserDefaults o, SwiftData x)
 - UserDefaults 값은 ViewModel의 @AppStorage를 통해서 관리
 - 언어 옵션이 바뀌면 화면 재갱신
 - 앱을 재실행 하면, 시스템 설정과 상관없이 로컬에 저장한 값을 읽어와서 화면에 반영함
 */

@MainActor
final class ContentViewModel: ObservableObject {
    private let userDefaultsManager = UserDefaultsManager.shared
    
    // 무의미한 초기값
    @Published var selectedLanguage: LanguageOptions = .english {
        didSet {
            guard selectedLanguage != oldValue else { return }

            Task { @MainActor in
                let option = selectedLanguage.rawValue
                userDefaultsManager.save(option, forKey: .languageOption)
            }
        }
    }
    @Published var isReady: Bool = false
    
    init () {
        checkLanguageOption()
    }
    
    private func checkLanguageOption() {
        // 로컬 저장된 값이 있으면 사용 (selectedOption)
        // 없으면, 시스템 설정값 사용 (defaultOption)
        if !userDefaultsManager.languageOption.isEmpty,
           let selectedOption = LanguageOptions(rawValue: userDefaultsManager.languageOption) {
            self.selectedLanguage = selectedOption
        } else {
            let defaultOption = preferredSystemLanguageOption()
            self.selectedLanguage = defaultOption

            Task { @MainActor in
                let option = defaultOption.rawValue
                userDefaultsManager.save(option, forKey: .languageOption)
            }
        }
        isReady = true
    }
    
    private func preferredSystemLanguageOption() -> LanguageOptions {
        // ex. "ko-KR" / "en-US"
        let preferredLanguageIdentifier = Locale.preferredLanguages.first ?? "en"
        if preferredLanguageIdentifier.hasPrefix(LanguageOptions.korean.rawValue) {
            return .korean
        } else {
            return .english
        }
    }
}

struct ContentView: View {
    @Environment(\.locale) private var locale
    
    // viewModel로 로직 분리
//    @EnvironmentObject private var userDefaultsViewModel: UserDefaultsViewModel
    
    @StateObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            if viewModel.isReady {
                listView
            } else {
                ProgressView()
            }
        }
        .environment(\.locale, Locale(identifier: viewModel.selectedLanguage.rawValue))
        // !!!: 원하는 인앱 설정값이 적용됨
        // invalid한 값이 들어가면 base language로 뜨는건가?
    }
    
    private var listView: some View {
        List {
            Section(header: Text("앱 설정")) {
                HStack(spacing: 0) {
                    Image(systemName: "globe")
                    
                    Text("언어")
                        .padding(.leading, 14)
                    
                    Spacer(minLength: 0)
                    
                    Picker("", selection: $viewModel.selectedLanguage) {
                        ForEach(LanguageOptions.allCases, id: \.self) { option in
                            Text(option.rawValue)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            
            Section(header: Text("현재 Locale")) {
                Text("안녕하세요")
                Text(locale.identifier) // !!!: 고정된 실제 시스템값이 노출됨
                Text(Date.now, format: .dateTime.year().month().day().weekday())
            }
        }
    }
}

#Preview {
    ContentView(
        viewModel: ContentViewModel()
    )
}
