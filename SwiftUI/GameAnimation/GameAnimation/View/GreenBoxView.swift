//
//  GreenBoxView.swift
//  GameAnimation
//
//  Created by Hyoju Son on 9/7/25.
//

import SwiftUI

/// - 고정 100x100, 추가 애니메이션 없음
struct GreenBoxView: View {
    let type: BoxType
    var onTap: () -> Void
    
    var body: some View {
        Rectangle()
            .fill(type.color)
            .frame(width: 100, height: 100)
            .overlay(BoxInnerContent())
            .onTapGesture {
                onTap()
            }
    }
}
