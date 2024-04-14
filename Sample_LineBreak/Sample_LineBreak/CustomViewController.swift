//
//  CustomViewController.swift
//  Sample_LineBreak
//
//  Created by 손효주 on 2022/12/18.
//

import UIKit

class CustomViewController: UIViewController {
    @IBOutlet weak var wordWrappingLabel: UILabel!
    @IBOutlet weak var truncatingTailLabel: UILabel!
    @IBOutlet weak var truncatingMiddleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }

    private func setupLayout() {
        wordWrappingLabel.lineBreakStrategy = .hangulWordPriority
        truncatingTailLabel.lineBreakStrategy = .hangulWordPriority
        truncatingMiddleLabel.lineBreakStrategy = .hangulWordPriority
    }
    
    @IBAction func attributedTextBtnTapped(_ sender: UIButton) {
        let viewController = AttributedTextViewController()
        present(viewController, animated: true)
    }
}
