import UIKit
import RxSwift
import RxCocoa
import RxRelay

final class MenuBar: UIView {
    
    var buttons = [UIButton]()
    
    private lazy var hStack: UIStackView = {
        let view = UIStackView()
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
        guard let selectedLabel = selectedLabel(selectedIndex: index) else { return }
        
        changeLayout(selectedIndex: index)
        boldDivider.snp.remakeConstraints { make in
            make.height.equalTo(2)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(selectedLabel)
        }
    }
    
    private func changeLayout(selectedIndex: Int) {
        buttons.enumerated().forEach { (index, label) in
            let isSelected = index == selectedIndex
            label.isSelected = isSelected
            label.titleLabel?.font = .systemFont(ofSize: 12, weight: isSelected ? .bold : .regular)
        }
    }

    private func selectedLabel(selectedIndex: Int) -> UIButton? {
        buttons[safe: selectedIndex]
    }
    
    private func layout() {
        backgroundColor = .white

        let labels = MenuType.allCases.map {
            createLabel(with: $0.title)
        }
        self.buttons = labels
        
        hStack.addArrangedSubview(labels[0])
        hStack.addArrangedSubview(labels[1])
        hStack.addArrangedSubview(labels[2])
        hStack.addArrangedSubview(labels[3])

        addSubview(hStack)
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(36)
        }
        
        addSubview(divider)
        divider.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addSubview(boldDivider)
    }
    
    private func createLabel(with title: String) -> UIButton {
        let view = UIButton(type: .custom)
        view.tintColor = .green
        view.setTitle(title, for: .normal)
        view.setTitleColor(.gray, for: .normal)
        view.setTitleColor(.black, for: .selected)
        view.titleLabel?.textAlignment = .center
        return view
    }
}

enum MenuType: Int, CaseIterable {
    case menu0
    case menu1
    case menu2
    case menu3
    
    var title: String {
        switch self {
        case .menu0:
            "0"
        case .menu1:
            "1"
        case .menu2:
            "2"
        case .menu3:
            "3"
        }
    }
}
