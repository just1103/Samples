//
//  Untitled.swift
//  GameAnimation
//
//  Created by Hyoju Son on 9/7/25.
//

import SwiftUI 

/// - 초기 등장 기준:
///   0.0~0.1s: opacity 0→1 & 아래로 10px 내려오며 등장 (위에서 시작해 아래로)
///   0.2~1.2s: 왼쪽으로 20px 이동
///   3.2s: 좌우 반전
///   3.2~4.2s: 오른쪽으로 20px 이동
struct RedBoxView: View {
    var onTap: () -> Void
    
    @State private var opacity: CGFloat = 0
    @State private var offsetY: CGFloat = -10
    @State private var offsetX: CGFloat = 0
    @State private var flipped: Bool = false  // 좌우 반전
    
    // 최초 1회만 인트로 실행
    @State private var didIntro = false
    @State private var animationTask: Task<Void, Never>? = nil
    
    var body: some View {
        Rectangle()
            .fill(.red)
            .frame(width: 132, height: 100)
            .overlay(BoxInnerContent())
            .scaleEffect(x: flipped ? -1 : 1, y: 1, anchor: .center)
            .opacity(opacity)
            .offset(x: offsetX, y: offsetY)
            .onTapGesture { onTap() }
            .onAppear { startLoop() }
            .onDisappear { stopLoop() }
            .animation(.default, value: flipped) // 뒤집히는 효과 스무스하게 주려면 필요
    }

    private func startLoop() {
        animationTask?.cancel()
        animationTask = Task {
            // 초기 상태(인트로 준비)
            opacity = 0
            offsetY = -10
            offsetX = 0
            flipped = false
            didIntro = false
            
            while !Task.isCancelled {
                if !didIntro {
                    // --- 인트로: 0.0~0.1s 페이드 + 아래로 10px ---
                    withAnimation(.linear(duration: 0.1)) {
                        opacity = 1
                        offsetY = 0
                    }
                    // 0.1~0.2s 공백 유지
                    try? await Task.sleep(nanoseconds: 100_000_000)
                    didIntro = true
                }
                
                // 본 루프: 좌(−20) → flip → 우(0) → flip → 좌…
                while !Task.isCancelled {
                    // 좌로 이동 (1.0s)
                    withAnimation(.easeInOut(duration: 1.0)) {
                        offsetX = -20
                    }
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    
                    // 대기 2.0s (원 스펙 유지)
                    try? await Task.sleep(nanoseconds: 2_000_000_000)
                    
                    // 좌 끝점에서 flip
                    flipped.toggle()
                    
                    // 우로 이동 (원위치, 1.0s)
                    withAnimation(.easeInOut(duration: 1.0)) {
                        offsetX = 0
                    }
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    
                    // 대기 2.0s
                    try? await Task.sleep(nanoseconds: 2_000_000_000)
                    
                    // 우 끝점에서 flip
                    flipped.toggle()
                    // 반복 → 다시 좌로 이동
                }
            }
        }
    }
    
    private func stopLoop() {
        animationTask?.cancel()
        animationTask = nil
    }
}
