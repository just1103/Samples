//
//  LocaleAppStorageApp.swift
//  LocaleAppStorage
//
//  Created by Hyoju Son on 12/28/25.
//

import SwiftUI

class UserDefaultsManager: ObservableObject {
    @AppStorage(Key.languageOption.rawValue) private(set) var languageOption: String = ""
    
    enum Key: String {
        case languageOption
    }
    
    func save(_ value: Any?, forKey key: Key) {
        switch key {
        case .languageOption:
            guard let value = value as? String else {
                return
            }
            self.languageOption = value
        }
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
