//
//  BoxInnerContent.swift
//  GameAnimation
//
//  Created by Hyoju Son on 9/7/25.
//

import SwiftUI

struct BoxInnerContent: View {
    var body: some View {
        Image(systemName: "figure.walk")
            .scaleEffect(x: -1, y: 1, anchor: .center)
            .font(.system(size: 28, weight: .regular))
            .foregroundStyle(.white)
    }
}
