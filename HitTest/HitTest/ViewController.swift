//
//  ViewController.swift
//  HitTest
//
//  Created by 손효주 on 2024/05/23.
//

import UIKit

class ViewController: UIViewController {

    private lazy var button1: UIButton = {
        let button = UIButton()
        button.setTitle("11111111111", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        return button
    }()
    
    private lazy var button2: UIButton = {
        let button = UIButton()
        button.setTitle("2222", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        return button
    }()
    
    @objc private func button1Tapped() {
        print("1 ... tapped")
    }
    
    @objc private func button2Tapped() {
        print("2 ... tapped")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(button1)
        view.addSubview(button2)
        
        NSLayoutConstraint.activate([
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            button2.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

}
