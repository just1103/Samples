//
//  ViewController.swift
//  ModuleA
//
//  Created by 손효주 on 7/3/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let aimage = Asset.Images3.appleLogo.image
//        let aimage = UIImage(named: "AppleLogo")
        let imageView = UIImageView(image: aimage)
        imageView.backgroundColor = .blue
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        // 모듈 A에서 B 쓰기 가능한지 테스트
        // public 이니까 가능해야함
//        UIImage.infoB // 왜 못찾지
        
//        Test.infoA
        
    }


}

