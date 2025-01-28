//
//  ContentView.swift
//  BasicViews
//
//  Created by Hyoju Son on 1/28/25.
//

import SwiftUI

struct RainbowView: View {
    var body: some View {
        
        // viewModifier : padding, background 등
        // 각각 some View를 반환함
        // 그래서 Text는 1개지만, 무지개 탑을 만들 수 있음
        Text("Hello, world!")
            .padding(10)
            .background(Color.red)
            .padding(10)
            .background(Color.orange)
            .padding(10)
            .background(Color.yellow)
            .padding(10)
            .background(Color.green)
            .padding(10)
            .background(Color.blue)
    }
}

#Preview {
    RainbowView()
}
