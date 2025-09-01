//
//  ParallaxMarqueeView.swift
//  MarqueeImage
//
//  Created by Hyoju Son on 9/2/25.
//

import SwiftUI

struct ParallaxMarqueeView: View {
    
    // 원근감이 느껴지도록 뒷 이미지는 천천히, 앞 이미지는 빠르게 움직임
    var body: some View {
        ZStack {
            MarqueeView(
                imageName: "BG",
                duration: 5.0,
                vPadding: 0
            )
            
            MarqueeView(
                imageName: "KDH",
                duration: 3.0,
                vPadding: 200
            )
        }
    }
}

#Preview {
    ParallaxMarqueeView()
}
