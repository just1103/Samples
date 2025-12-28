//
//  LocaleApp.swift
//  Locale
//
//  Created by Hyoju Son on 12/28/25.
//

import SwiftUI
import SwiftData

@main
struct LocaleApp: App {
    // 컴파일/런타임 에러는 안나지만 App은 View life cycle과 달라서 부정확함
    // AppRootView 추가하여 초기화 시점 분리 
//    @Environment(\.modelContext) private var modelContext
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            AppSettingsEntity.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            AppRootView()
        }
        .modelContainer(sharedModelContainer)
    }
}
