import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var viewList = [view1, view2, view3]
    
    private let visibleArea: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.clipsToBounds = true
        return view
    }()
    private let view1: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    private let view2: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    private let view3: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            updateLayout(visibleIndex: index)
            index += 1
            
            if index == 3 {
                index = -1
            }
        }

    }
    
    private func updateLayout(visibleIndex: Int) {
        let viewToShow = viewList[safe: index]
        let viewToHide = viewList[safe: index - 1]
        
        UIView.animate(withDuration: 2.0, delay: 0, options: [.curveEaseInOut]) {
            viewToShow?.snp.updateConstraints { make in
                make.centerY.equalToSuperview()
            }
            
            viewToHide?.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(-100)
            }
            
            self.view.layoutIfNeeded()
        } completion: { _ in
            viewToHide?.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(100)
            }
        }
    }

    private func layout() {
        view.backgroundColor = .lightGray
        view.addSubview(visibleArea)
        
        visibleArea.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(100)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        viewList.forEach { view in
            visibleArea.addSubview(view)
            view.snp.makeConstraints { make in
                make.width.equalTo(200)
                make.height.equalTo(50)
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(100)
            }
        }
    }

}

