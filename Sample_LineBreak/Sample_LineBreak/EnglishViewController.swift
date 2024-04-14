//
//  ViewController.swift
//  Sample_LineBreak
//
//  Created by 손효주 on 2022/12/17.
//

import UIKit

class EnglishViewController: UIViewController {
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
    
    @IBAction func koreanBtnTapped(_ sender: UIButton) {
        let viewController = KoreanViewController()
        present(viewController, animated: true)
    }
}
