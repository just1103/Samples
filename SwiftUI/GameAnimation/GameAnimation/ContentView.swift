//
//  ContentView.swift
//  GameAnimation
//
//  Created by Hyoju Son on 9/7/25.
//

import SwiftUI

struct ContentView: View {
    @State private var current: BoxType? = nil
    @State private var isReady = false
    
    var body: some View {
        boxView
        .onAppear {
            // 1. 화면 준비 후 1초 뒤 빨간색 등장
            Task {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                withAnimation(.easeInOut(duration: 0.25)) {
                    self.current = .red
                }
            }
        }
    }
    
    private var boxView: some View {
        Group {
            if let current {
                switch current {
                case .red:
                    RedBoxView {
                        // 2. 빨간색 탭 시 노란색으로 전환 시작
                        withAnimation(.easeInOut(duration: 0.2)) {
                            self.current = .yellow
                        }
                    }
//                .transition(.opacity) // 초기 등장 전환
                    
                case .yellow:
                    YellowBoxView(
                        onFinishedBounce: {
                            // 2. "시간의 흐름"에 따라 바운스 종료 후 초록으로 전환
//                            withAnimation(.easeInOut(duration: 0.2)) {
                                self.current = .green
//                            }
                        }
                    )
//                .transition(.opacity)
                    
                case .green:
                    GreenBoxView {
                        self.current = .red
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
