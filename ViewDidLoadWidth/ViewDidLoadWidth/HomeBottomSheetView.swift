import UIKit
import SnapKit

final class HomeBottomSheetView: UIView {
    
    private lazy var dimView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.alpha = 0
        return view
    }()

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.loadCachedImage(of: "https://www.donanimhaber.com/images/images/haber/176228/src_340x1912x3-body-problem-zirvedeki-yerini-koruyor.jpg")
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25.0 / 2.0
        button.backgroundColor = .black.withAlphaComponent(0.5)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        button.addAction(UIAction { [weak self] _ in self?.close() }, for: .touchUpInside)
        return button
    }()
    
    private lazy var todayButton: UIButton = {
        let button = UIButton()
        button.setTitle("Don’t show this again today", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
//        button.addAction(UIAction { [weak self] _ in self?.closeToday() }, for: .touchUpInside) // 생략
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        close()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.addRoundCorner(corners: [.topLeft, .topRight], radii: 16.0)
    }
    
    private func layout() {
        backgroundColor = .clear
        
        addSubview(dimView)
        dimView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(snp.bottom)
            make.height.equalTo(snp.width)
        }
        
        addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(imageView.snp.top).offset(-10)
            make.width.height.equalTo(25)
        }
        
        addSubview(todayButton)
        todayButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalTo(closeButton)
        }
    }
    
    private func setImageViewOffsetY(to offsetY: CGFloat) {
        imageView.snp.updateConstraints { make in
            make.top.equalTo(snp.bottom).offset(offsetY)
        }
        layoutIfNeeded()
    }

    // MARK: - Public
    func show() {
        layoutIfNeeded()

        UIView.animate(withDuration: 0.25) {
            self.dimView.alpha = 1
            self.setImageViewOffsetY(to: -self.imageView.bounds.size.height)
        }
    }
    
    func close() {
        UIView.animate(withDuration: 0.25) {
            self.dimView.alpha = 0
            self.setImageViewOffsetY(to: 0)
        } completion: { [weak self] _ in
            self?.removeFromSuperview()
        }
    }
}
