import UIKit
import SnapKit

class ViewController: UIViewController {

    var view1: UILabel = {
        let view = UILabel()
        view.backgroundColor = .red
        view.text = "test test test test test 1"
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    var view2: UILabel = {
        let view = UILabel()
        view.backgroundColor = .blue
        view.text = "test test test test test 2"
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    var view3: UILabel = {
        let view = UILabel()
        view.backgroundColor = .green
        view.text = "test 3"
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
//        view.alignment = .fill // 바깥 stackView는 fill
//        view.distribution = .fillEqually
        view.axis = .vertical
        view.spacing = 10
        view.backgroundColor = .systemMint
        return view
    }()
    
    lazy var outerStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.distribution = .fill
        view.axis = .vertical
        view.spacing = 10
        view.backgroundColor = .black
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(outerStackView)
        outerStackView.addArrangedSubview(stackView)
        outerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)  // bottom 지정 안함
            make.leading.trailing.equalToSuperview()
        }
        
        // 이렇게 배치하면 inset 제대로 안먹고 layout 찌그러져서
        // view1/3 묶어서 hStack 만들어야함
        stackView.addArrangedSubview(view1)
        stackView.addArrangedSubview(view2)
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        view.addSubview(view3)
        view3.snp.makeConstraints { make in
            make.centerY.equalTo(view1)
            make.leading.equalTo(view1.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
    }
}

