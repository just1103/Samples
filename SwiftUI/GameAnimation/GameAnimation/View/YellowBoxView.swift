//
//  YellowBoxView.swift
//  GameAnimation
//
//  Created by Hyoju Son on 9/7/25.
//

import SwiftUI

/// - 크기 기준: 가로 88, 세로 72
/// - 0~0.1s : 50% 크기 & opacity 30% → 100% 크기 & opacity 100%
/// - 0.1~0.7s : 90% ↔ 100% 를 번갈아가며 바운스
struct YellowBoxView: View {
    var onFinishedBounce: () -> Void
    
    private let baseSize = CGSize(width: 88, height: 72)
    @State private var scale: CGFloat = 0.5
    @State private var opacity: CGFloat = 0.3
    
    var body: some View {
        Rectangle()
            .fill(.yellow)
            .frame(width: baseSize.width, height: baseSize.height)
            .overlay(BoxInnerContent())
            .opacity(opacity)
            .scaleEffect(scale, anchor: .center)
            .onAppear {
                Task {
                    // 0~0.1s : 페이드업 + 확대
                    withAnimation(.easeOut(duration: 0.1)) {
                        opacity = 1.0
                        scale = 1.0
                    }
                    try? await Task.sleep(nanoseconds: 100_000_000)
                    
                    // 0.1~0.7s : 0.6초 동안 90% ↔ 100% 바운스
                    // 0.6초 / 0.1초 스텝 = 6스텝 → 왕복 3번
                    for _ in 0..<3 {
                        withAnimation(.spring(response: 0.1, dampingFraction: 0.6)) {
                            scale = 0.90
                        }
                        try? await Task.sleep(nanoseconds: 100_000_000)
                        withAnimation(.spring(response: 0.1, dampingFraction: 0.6)) {
                            scale = 1.00
                        }
                        try? await Task.sleep(nanoseconds: 100_000_000)
                    }
                    
                    // 바운스 종료 콜백 → 초록 전환
                    onFinishedBounce()
                }
            }
    }
}
