import UIKit

class CustomHeader: UITableViewHeaderFooterView {
    let reuseIndentifier = "CustomHeader"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("btn", for: .normal)
        button.titleLabel?.textColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.layer.cornerRadius = 2.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    func setupUI(with titleText: String) {
        titleLabel.text = titleText
        
        addSubview(titleLabel)
        addSubview(editButton)
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        editButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 50, height: 40))
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
}
