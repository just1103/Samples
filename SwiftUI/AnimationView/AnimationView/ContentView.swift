//
//  ContentView.swift
//  AnimationView
//
//  Created by Hyoju Son on 10/1/25.
//

import SwiftUI

struct AnimationView: View {
    @State private var applysOffsetY = false

    var body: some View {
        VStack {
            Spacer()
            
            Circle()
                .fill(Color.mint)
                .frame(width: 100, height: 100)
                .offset(y: applysOffsetY ? 200 : -100)
//                .animation(.default, value: applysOffsetY)
//                .animation(.linear(duration: 1.0), value: applysOffsetY)
//                .animation(.easeInOut(duration: 1.0), value: applysOffsetY)
//                .animation(.snappy(duration: 1.0), value: applysOffsetY)
//                .animation(.spring(duration: 1.0), value: applysOffsetY)
//                .animation(.bouncy(duration: 1.0), value: applysOffsetY)
                .animation(.smooth(duration: 1.0), value: applysOffsetY)

            Spacer()
            
            Button("Animate !") {
                applysOffsetY.toggle()
            }
            .padding()
        }
    }
}

#Preview {
    AnimationView()
}
