import UIKit
import RxSwift
import RxCocoa

final class MenuBarView: UIView {
    
    let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Menu 0"
        label.textAlignment = .center
        return label
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Menu 1"
        label.textAlignment = .center
        return label
    }()
    
    let thirdLabel: UILabel = {
        let label = UILabel()
        label.text = "Menu 2"
        label.textAlignment = .center
        return label
    }()
    
    // TODO: 확장성을 위해 CollectionView로 대체
    private lazy var hStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [firstLabel, secondLabel, thirdLabel])
        view.distribution = .fillEqually
        view.alignment = .fill
        return view
    }()
    
    private lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var boldDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        setSelectedIndex(to: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelectedIndex(to index: Int) {
        if index == 0 {
            firstLabel.font = .systemFont(ofSize: 16, weight: .bold)
            firstLabel.textColor = .black
            secondLabel.font = .systemFont(ofSize: 16, weight: .regular)
            secondLabel.textColor = .gray
            thirdLabel.font = .systemFont(ofSize: 16, weight: .regular)
            thirdLabel.textColor = .gray
            
            boldDivider.snp.remakeConstraints { make in
                make.height.equalTo(3)
                make.bottom.equalToSuperview()
                make.leading.trailing.equalTo(firstLabel)
            }
        } else if index == 1 {
            firstLabel.font = .systemFont(ofSize: 16, weight: .regular)
            firstLabel.textColor = .gray
            secondLabel.font = .systemFont(ofSize: 16, weight: .bold)
            secondLabel.textColor = .black
            thirdLabel.font = .systemFont(ofSize: 16, weight: .regular)
            thirdLabel.textColor = .gray
            
            boldDivider.snp.remakeConstraints { make in
                make.height.equalTo(3)
                make.bottom.equalToSuperview()
                make.leading.trailing.equalTo(secondLabel)
            }
        } else if index == 2 {
            firstLabel.font = .systemFont(ofSize: 16, weight: .regular)
            firstLabel.textColor = .gray
            secondLabel.font = .systemFont(ofSize: 16, weight: .regular)
            secondLabel.textColor = .gray
            thirdLabel.font = .systemFont(ofSize: 16, weight: .bold)
            thirdLabel.textColor = .black
            
            boldDivider.snp.remakeConstraints { make in
                make.height.equalTo(3)
                make.bottom.equalToSuperview()
                make.leading.trailing.equalTo(thirdLabel)
            }
        }
    }
    
    private func layout() {
        backgroundColor = .white

        addSubview(hStack)
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(52)
        }
        
        addSubview(divider)
        divider.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addSubview(boldDivider)
    }
}
