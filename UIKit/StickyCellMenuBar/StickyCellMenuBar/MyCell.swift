import UIKit
import SnapKit

class MyCell: UICollectionViewCell {
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        label.text = text
    }
    
    private func layout() {
        contentView.backgroundColor = .systemMint
        contentView.layer.borderColor = UIColor.yellow.cgColor
        contentView.layer.borderWidth = 1.0
        
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
}
