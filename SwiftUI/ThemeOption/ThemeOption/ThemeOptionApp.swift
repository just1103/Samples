//
//  ThemeOptionApp.swift
//  ThemeOption
//
//  Created by Hyoju Son on 1/4/26.
//

import SwiftUI

@main
struct ThemeOptionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: ContentViewModel()
            )
        }
    }
}
