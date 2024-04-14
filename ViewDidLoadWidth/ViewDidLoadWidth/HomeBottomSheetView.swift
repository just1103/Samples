import UIKit
import SnapKit

final class HomeBottomSheetView: UIView {
    
    private lazy var dimView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.alpha = 0
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = true
        view.image = UIImage(systemName: "plus")
        return view
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
        contentView.addRoundCorner(corners: [.topLeft, .topRight], radii: 16.0)
    }
    
    private func layout() {
        backgroundColor = .clear
        
        addSubview(dimView)
        dimView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(snp.bottom)
            make.height.equalTo(snp.width)
        }
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(snp.width)
        }
    }
    
    private func setContentView(offsetY: CGFloat) {
        contentView.snp.updateConstraints { make in
            make.top.equalTo(snp.bottom).offset(offsetY)
        }
        layoutIfNeeded()
    }

    // MARK: - Public
    func show() {
        layoutIfNeeded()

        UIView.animate(withDuration: 0.25) {
            self.dimView.alpha = 1
            self.setContentView(offsetY: -self.contentView.bounds.size.height)
        }
    }
    
    func close() {
        UIView.animate(withDuration: 0.25) {
            self.dimView.alpha = 0
            self.setContentView(offsetY: 0)
        } completion: { [weak self] _ in
            self?.removeFromSuperview()
        }
    }
}
