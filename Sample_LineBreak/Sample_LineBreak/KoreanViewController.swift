//
//  KoreanViewController.swift
//  Sample_LineBreak
//
//  Created by 손효주 on 2022/12/17.
//

import UIKit

class KoreanViewController: UIViewController {
    @IBOutlet weak var hangulLabel: UILabel!
    @IBOutlet weak var pushOutLabel: UILabel!
    @IBOutlet weak var standardLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    private func setupLayout() {
        hangulLabel.lineBreakStrategy = .hangulWordPriority
        pushOutLabel.lineBreakStrategy = .pushOut
        standardLabel.lineBreakStrategy = .standard
    }
    
    @IBAction func customBtnTapped(_ sender: UIButton) {
        let viewController = CustomViewController()
        present(viewController, animated: true)
    }
}
