//
//  UIImageView+init.swift
//  Sample_GIF
//
//  Created by 손효주 on 2022/12/10.
//

import UIKit

extension UIImageView {
    convenience init?(gifNamed: String, animationDuration: Double = 1.0) { // UIImageView(named:) 처럼 만들어봄
        guard let gifURL = Bundle.main.url(forResource: gifNamed, withExtension: "gif"),  // 사용할 gif 파일의 경로
              let gifData = try? Data(contentsOf: gifURL),
              let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { // gif 데이터를 통해 CGImageSource를 만들겠다
            return nil
        }
        
        var images = [UIImage]()
        // Finder에서 gif 파일을 열면 여러 장의 이미지가 들어있다
        // gif 파일을 구성하는 이 이미지들의 개수 == CGImageSourceGetCount
        let imageCount = CGImageSourceGetCount(source)
        for index in 0..<imageCount {
            // for문을 통해 개별 이미지에 접근할 거다 (타입 변환 CGImage => UIImage)
            if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        
        // gif 이미지들을 담고 있는 UIImageView를 만든다
        // duration == gif 애니메이션이 지속될 시간 (1초가 적당한듯)
        let animatedImage = UIImage.animatedImage(with: images, duration: animationDuration)
        self.init(image: animatedImage)
    }
}
