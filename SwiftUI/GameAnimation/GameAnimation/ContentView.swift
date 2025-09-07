//
//  ContentView.swift
//  GameAnimation
//
//  Created by Hyoju Son on 9/7/25.
//

import SwiftUI

struct ContentView: View {
    @State private var currentType: BoxType? = nil
    @State private var isReady = false
    
    var body: some View {
        boxView
        .onAppear {
            // 1. 화면 준비 후 1초 뒤 빨간색 등장
            Task {
                // 1초 후에 rectangle 등장
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.currentType = .red
                }
            }
        }
    }
    
    private var boxView: some View {
        Group {
            if let currentType {
                switch currentType {
                case .red:
                    RedBoxView {
                        // 2. 빨간색 탭 시 노란색으로 전환 시작
//                        withAnimation(.easeInOut(duration: 0.2)) {
                            self.currentType = .yellow
//                        }
                    }
//                .transition(.opacity) // 초기 등장 전환
                    
                case .yellow:
                    YellowBoxView(
                        onFinishedBounce: {
                            // 2. "시간의 흐름"에 따라 바운스 종료 후 초록으로 전환
//                            withAnimation(.easeInOut(duration: 0.2)) {
                                self.currentType = .green
//                            }
                        }
                    )
//                .transition(.opacity)
                    
                case .green:
                    GreenBoxView {
                        self.currentType = .red
                    }
//                .transition(.opacity)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
