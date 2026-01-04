//
//  ThemeOptionApp.swift
//  ThemeOption
//
//  Created by Hyoju Son on 1/4/26.
//

import SwiftUI

@main
struct ThemeOptionApp: App {
    // !!!: 앱 최상위에서 ThemeStore 들고 있음. 여러 화면에 공통 적용하기 때문
    @StateObject private var themeStore = ThemeStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeStore)
                .preferredColorScheme(themeStore.preferredColorScheme)
        }
    }
}
