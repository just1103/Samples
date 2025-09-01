//
//  ContentView.swift
//  MarqueeImage
//
//  Created by Hyoju Son on 9/1/25.
//

import SwiftUI

struct MarqueeView: View {
    let imageName: String = "Shape"
    
    // 시작 위치: 스크린 왼쪽이 이미지 왼쪽 끝
    @State private var offset: CGFloat = 0
    
    var body: some View {
        // ex.
        // 원본 이미지 크기 : 2000 × 500 (가로/세로 ratio = imageWidth/imageHeight = 4:1)
        // 스크린 상의 이미지 높이 : 100 (= viewportHeight)
        // => *총 이미지 너비 (스크린을 벗어난 영역을 포함한 너비) : viewportHeight * image ratio = 400
        GeometryReader { geo in
            // 스크린 크기
            let viewportWidth = geo.size.width
            let viewportHeight = geo.size.height
            
            // 이미지 자체 크기
            let image = UIImage(named: imageName)
            let imageWidth = image?.size.width ?? 1
            let imageHeight = image?.size.height ?? 1
            let imageRatio = imageWidth / imageHeight
            
            VStack(spacing: 0) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
//                    .scaledToFit()
                    .frame(height: viewportHeight)
                    .offset(x: offset)
                    .clipped()
                    .background(Color.green)
//                    .padding(.vertical, 100) // ???: 왜 top에만 들어가지?
                    .onAppear {
                        // *총 이미지 너비
                        let totalWidth = viewportHeight * imageRatio
                        let delta = max(0, totalWidth - viewportWidth)
                        
                        if offset == 0 {
                            let _ = print("@@@ totalWidth", totalWidth) // 1390.5
                            let _ = print("@@@ imageWidth", imageWidth) // 42
                            let _ = print("@@@ viewportWidth", viewportWidth) // 402
                            let _ = print("@@@ delta", delta) // 988.5
                        }
                        
                        // 이미지 왼쪽을 -delta만큼 이동 (애니메이션)
                        // -인 이유? : 화면이 오른쪽으로 이동하는 것처럼 보이려면 => 이미지를 왼쪽으로 이동시켜야 함)
                        // 끝 위치 : 스크린 오른쪽이 이미지 오른쪽 끝
                        withAnimation(.easeInOut(duration: 4.0)) {
                            offset = -delta
                        }
//                        withAnimation(.linear(duration: 4.0).repeatForever(autoreverses: true)) {
//                            offset = -delta
//                        }

// 애니메이션 방식이 timer와 다른 점 :  0.1초 마다 왼쪽으로 얼마 이동 (X)
// delta 만큼 이미지를 왼쪽으로 움직일건데, 이 전체를 4초에 걸쳐서 보여줘 (O)
                    }
            }
//            .padding(.vertical, 100) // ???: 왜 top에만 들어가지?
            .background(Color.pink)
            
        }
        .padding(.vertical, 100)
        .ignoresSafeArea(.all)
        .background(Color.yellow)
    }
}

#Preview {
    MarqueeView()
}
