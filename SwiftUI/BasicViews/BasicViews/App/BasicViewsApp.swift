//
//  BasicViewsApp.swift
//  BasicViews
//
//  Created by Hyoju Son on 1/28/25.
//

import SwiftUI

@main
struct BasicViewsApp: App {
    private let info = CommonInfo()
    
    var body: some Scene {
        WindowGroup {
//            ColorSchemeView()
            
            CommonInfoView()
                .environmentObject(info)
        }
    }
}
