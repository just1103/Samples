import UIKit

class ShadowedView: UIView {
    
    private let cornerRadius: CGFloat = 16.0
    private let shadowLayer = CALayer()
    private let backgroundLayer = CALayer()
    
    // 이것도 가능
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
//        shadowLayer.frame = bounds
//        shadowLayer.shadowPath = shadowPath.cgPath
//
//        backgroundLayer.frame = bounds
//    }
    
    override var bounds: CGRect {
        didSet {
            guard oldValue != bounds else { return }
            
            // shadowLayer의 path 설정
            let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            shadowLayer.frame = bounds
            shadowLayer.shadowPath = shadowPath.cgPath
    
            // cornerLayer의 크기와 위치 설정
            backgroundLayer.frame = bounds
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        // 그림자 설정
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 4)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 2
        layer.addSublayer(shadowLayer)
        
        // Corner Layer 설정
        backgroundLayer.backgroundColor = UIColor.systemBlue.cgColor
        backgroundLayer.cornerRadius = cornerRadius
        layer.addSublayer(backgroundLayer)
        
        // !!!: 주의 - 이거 쓰면 그림자도 함께 clip됨
//        layer.cornerRadius = 16
//        layer.masksToBounds = true
//        clipsToBounds = true
    }
    
}
