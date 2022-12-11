//
//  SimpleRefreshControl.swift
//  Sample_GIF
//
//  Created by 손효주 on 2022/12/10.
//

import UIKit
import SnapKit

final class SimpleRefreshControl: UIRefreshControl {
    override init() {
        super.init()
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        // 아까 만든 UIImageView custom init 활용
        // bundle에 넣은 gif 파일이름 입력
        guard let loadingImageView = UIImageView(gifNamed: "simpson") else { return }
        
        addSubview(loadingImageView) // RefreshControl의 subview로 추가
        loadingImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(63.0)
            make.height.equalTo(45.0)
        }
    }
}
