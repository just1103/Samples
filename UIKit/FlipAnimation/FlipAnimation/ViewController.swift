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
    private var isInitial = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            updateLayout(visibleIndex: index, isInitial: isInitial)
            isInitial = false
            index += 1
            
            if index == viewList.count {
                index = 0
            }
        }
    }
    
    private func updateLayout(visibleIndex: Int, isInitial: Bool) {
        // 0 1 2 -> 0 1 2 -> 0 1 2 ...
        let viewToShow = viewList[safe: index]
        
        // x 0 1 -> 2 0 1 -> 2 0 1 ...
        let editedIndex = index == 0 ? 2 : index - 1
        let viewToHide = isInitial ? nil : viewList[safe: editedIndex]
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseInOut]) {
            viewToShow?.snp.updateConstraints { make in
                make.centerY.equalToSuperview()
            }
            
            viewToHide?.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(-100) // 박스 위
            }
            
            self.view.layoutIfNeeded()
        } completion: { _ in
            viewToHide?.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(100) // 박스 아래
            }
        }
    }

    private func layout() {
        view.backgroundColor = .white
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

