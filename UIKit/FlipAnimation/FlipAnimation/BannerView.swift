import UIKit
import SnapKit
import Lottie

final class BannerView: UIView {
    
    enum Animation {
        case alarm
        case arrowUp
        
        var fileName: String {
            switch self {
            case .alarm:
                "hover-alarm"
            case .arrowUp:
                "arrowup"
            }
        }
    }
    
    private lazy var hStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [leftLabel, rightLabel, animationView])
        view.directionalLayoutMargins = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
        view.isLayoutMarginsRelativeArrangement = true
        view.spacing = 4
        view.alignment = .center
        return view
    }()
    
    private var leftLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12, weight: .bold)
        view.textColor = .white
        return view
    }()
    
    private var rightLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12, weight: .bold)
        view.textColor = .red
        return view
    }()
    private let animationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop
        view.backgroundBehavior = .pauseAndRestore
        view.isUserInteractionEnabled = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(leftText: String, rightText: String, animation: Animation) {
        leftLabel.text = leftText
        rightLabel.text = rightText
        animationView.animation = .named(animation.fileName)
        animationView.play()
    }
    
    private func layout() {
        backgroundColor = .black
        layer.opacity = 0.7
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray6.cgColor
        layer.cornerRadius = 14
        clipsToBounds = true
        
        snp.makeConstraints { make in
            make.height.equalTo(28)
        }
        
        addSubview(hStack)
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        animationView.snp.makeConstraints { make in
            make.width.height.equalTo(16)
        }
    }
    
}
