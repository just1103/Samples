//
//  AppRootView.swift
//  Locale
//
//  Created by Hyoju Son on 12/28/25.
//

import SwiftUI
import SwiftData

struct AppRootView: View {
    // SwiftData
    @Environment(\.modelContext) private var modelContext
    @Query private var appSettingsRecords: [AppSettingsEntity]

    @State private var selectedLanguage: LanguageOptions = .english // 무의미한 기본값
    @State private var isReady = false

    var body: some View {
        Group {
            if isReady {
                ContentView(selectedLanguage: languageBinding)
            } else {
                ProgressView()
            }
        }
        .environment(\.locale, Locale(identifier: selectedLanguage.rawValue))
        .task {
            loadAppSettingsIfNeeded()
            isReady = true
        }
    }

    // 하위 뷰에 넘겨줘야해서 Binding 타입으로 정의
    // viewModel @Published로 분리해도 됨
    private var languageBinding: Binding<LanguageOptions> {
        Binding(
            get: { selectedLanguage },
            set: { newValue in
                selectedLanguage = newValue
                saveSelectedLanguage(newValue)
                try? modelContext.save()
            }
        )
    }

    private func loadAppSettingsIfNeeded() {
        // 항상 1개만 유지
        if appSettingsRecords.count > 1 {
            for record in appSettingsRecords.dropFirst() {
                modelContext.delete(record)
            }
        }

        if let record = appSettingsRecords.first {
            selectedLanguage = record.languageOption
        } else {
            // 로컬 저장한 값이 없으면 시스템 설정값 (default)로 적용
            let defaultLanguage = preferredSystemLanguageOption()
            modelContext.insert(AppSettingsEntity(selectedLanguageCode: defaultLanguage.rawValue))
            selectedLanguage = defaultLanguage
            try? modelContext.save()
        }
    }

    private func saveSelectedLanguage(_ languageOption: LanguageOptions) {
        // 항상 1개만 유지
        if let record = appSettingsRecords.first {
            record.selectedLanguageCode = languageOption.rawValue
        } else {
            modelContext.insert(AppSettingsEntity(selectedLanguageCode: languageOption.rawValue))
        }

        // 방어 로직 - 여러 개가 생겼다면 정리
        if appSettingsRecords.count > 1 {
            for record in appSettingsRecords.dropFirst() {
                modelContext.delete(record)
            }
        }

        try? modelContext.save()
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
