//
//  LocaleAppStorageApp.swift
//  LocaleAppStorage
//
//  Created by Hyoju Son on 12/28/25.
//

import SwiftUI

class UserDefaultsManager: ObservableObject {
    @AppStorage(Keys.languageOption.rawValue) var languageOption: String = ""
    
    private enum Keys: String {
        case languageOption
    }
    
    static let shared = UserDefaultsManager()
    private init() {}
}

@main
struct LocaleAppStorageApp: App {
    // 이렇게 environmentObject로 넘겨도 되지만
    // 싱글톤으로 만들면 관리가 더 쉬울듯!
//    @StateObject var userDefaultsViewModel = UserDefaultsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: ContentViewModel()
            )
//            .environmentObject(UserDefaultsViewModel)
        }
    }
}
