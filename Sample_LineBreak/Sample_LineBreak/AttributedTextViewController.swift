//
//  AttributedTextViewController.swift
//  Sample_LineBreak
//
//  Created by 손효주 on 2022/12/18.
//

import UIKit

class AttributedTextViewController: UIViewController {
    @IBOutlet weak var container: UIStackView!
    @IBOutlet weak var hangulEnglishLabel: UILabel!
    @IBOutlet weak var hangulKoreanLabel: UILabel!
    
    @IBOutlet weak var longEnglishLabel: UILabel!
    @IBOutlet weak var longKoreanLabel: UILabel!
    
    private lazy var customLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineBreakStrategy = .hangulWordPriority
        paragraphStyle.alignment = .center
        paragraphStyle.minimumLineHeight = 21
        
        let fullText = "안녕하세요. 애플사이다의 iOS 개발일지 블로그에 오셨네요. 메리 크리스마스. 저는 이따 아바타2 보러가요. 그럼 이만!"
        let attributedText = NSMutableAttributedString(
            string: fullText,
            attributes: [.foregroundColor: UIColor.darkGray,
                         .font: UIFont.systemFont(ofSize: 18, weight: .bold),
                         .underlineStyle: NSUnderlineStyle.single.rawValue,
//                         .strikethroughStyle: NSUnderlineStyle.single.rawValue,
//                         .strikethroughColor: UIColor.systemRed,
                         .paragraphStyle: paragraphStyle])
        
        attributedText.addAttribute(.font,
                                    value: UIFont.systemFont(ofSize: 11),
                                    range:(fullText as NSString).range(of: "그럼 이만!"))
        
        label.attributedText = attributedText
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupEnglishLabelsLayout()
        setupKoreanLabelsLayout()
        
        container.addArrangedSubview(customLabel)
    }
    
    // paragraphStyle.lineBreakMode 및 label.lineBreakMode 비교
    // 마지막에 설정한 값으로 최종 적용됨
    // NSMutableParagraphStyle 사용해서 그런듯
    private func setupEnglishLabelsLayout() {
        let text = "If you aren’t using styled text, this property applies to the entire text string in the text property. If you’re using styled text, assigning a new value to this property applies the line break mode to the entirety of the string in the attributedText property."
        
        // 방법-1. 먼저
//        hangulEnglishLabel.lineBreakMode = .byTruncatingMiddle
//        hangulEnglishLabel.lineBreakStrategy = .pushOut
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineBreakStrategy = .hangulWordPriority
        
        let attributedText = NSMutableAttributedString(
            string: text,
            attributes: [.foregroundColor: UIColor.darkGray,
                         .font: UIFont.systemFont(ofSize: 14),
                         .underlineStyle: NSUnderlineStyle.single.rawValue,
                         .paragraphStyle: paragraphStyle])
        hangulEnglishLabel.attributedText = attributedText
        
        // 방법-2. 나중에
        hangulEnglishLabel.lineBreakMode = .byTruncatingMiddle
        hangulEnglishLabel.lineBreakStrategy = .pushOut
        
        // --------------------------------------------
        
        // 방법-1. 먼저
//        longEnglishLabel.lineBreakMode = .byTruncatingMiddle
//        longEnglishLabel.lineBreakStrategy = .pushOut
        
        let paragraphStyle2 = NSMutableParagraphStyle()
        paragraphStyle2.lineBreakMode = .byTruncatingTail
        paragraphStyle2.lineBreakStrategy = .hangulWordPriority
        
        let attributedText2 = NSMutableAttributedString(
            string: text,
            attributes: [.foregroundColor: UIColor.darkGray,
                         .font: UIFont.systemFont(ofSize: 14),
                         .underlineStyle: NSUnderlineStyle.single.rawValue,
                         .paragraphStyle: paragraphStyle2])
        longEnglishLabel.attributedText = attributedText2
        
        // 방법-2. 나중에
        longEnglishLabel.lineBreakMode = .byTruncatingMiddle
        longEnglishLabel.lineBreakStrategy = .pushOut
    }

    private func setupKoreanLabelsLayout() {
        let text = "이 프로퍼티는 줄임표(…)로 잘라내거나 텍스트를 크으으을리핑하는 등 텍스트 시스템이 해당 컨테이너에 맞지 않는 줄을 배치하는 방법을 제어합니다. 이 속성은 줄임표(…)로 잘라내거나 텍스트를 클리핑하는 등 텍스트 시스템이 해당 컨테이너에 맞지 않는 줄을 배치하는 방법을 제어합니다. 하하."
        
        // 방법-1. 먼저
//        hangulKoreanLabel.lineBreakMode = .byTruncatingMiddle
//        hangulKoreanLabel.lineBreakStrategy = .pushOut
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineBreakStrategy = .hangulWordPriority
        
        let attributedText = NSMutableAttributedString(
            string: text,
            attributes: [.foregroundColor: UIColor.darkGray,
                         .font: UIFont.systemFont(ofSize: 14),
                         .underlineStyle: NSUnderlineStyle.single.rawValue,
                         .paragraphStyle: paragraphStyle])
        hangulKoreanLabel.attributedText = attributedText
        
        // 방법-2. 나중에
        hangulKoreanLabel.lineBreakMode = .byTruncatingMiddle
        hangulKoreanLabel.lineBreakStrategy = .pushOut
        
        // --------------------------------------------
        
        // 방법-1. 먼저
//        longKoreanLabel.lineBreakMode = .byTruncatingMiddle
//        longKoreanLabel.lineBreakStrategy = .pushOut
        
        let paragraphStyle2 = NSMutableParagraphStyle()
        paragraphStyle2.lineBreakMode = .byTruncatingTail
        paragraphStyle2.lineBreakStrategy = .hangulWordPriority
        
        let attributedText2 = NSMutableAttributedString(
            string: text,
            attributes: [.foregroundColor: UIColor.darkGray,
                         .font: UIFont.systemFont(ofSize: 14),
                         .underlineStyle: NSUnderlineStyle.single.rawValue,
                         .paragraphStyle: paragraphStyle2])
        longKoreanLabel.attributedText = attributedText2
        
        // 방법-2. 나중에
        longKoreanLabel.lineBreakMode = .byTruncatingMiddle
        longKoreanLabel.lineBreakStrategy = .pushOut
    }
}
