//
//  ContentView.swift
//  ScrollViewBottomInset
//
//  Created by Hyoju Son on 8/4/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var keyboardManager = KeyboardManager()
    @FocusState var isFocused: Bool
    @State var text: String = ""
    
    var body: some View {
        ScrollView {
            Rectangle()
                .foregroundStyle(Color.yellow)
                .frame(height: 300)
            
            TextField("입력해봐요", text: $text, axis: .vertical)
                .multilineTextAlignment(.leading)
                .padding(.leading, 50)
                .focused($isFocused)
                .background(Color.green)

//            Spacer()
        }
        .background(Color.blue)
        .contentMargins(.vertical, 16, for: .scrollContent)
        .contentMargins(.horizontal, 24, for: .scrollContent)
        .background(Color.mint)
    }
}

#Preview {
    ContentView()
}
