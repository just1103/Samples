import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var viewList = [view1, view2, view3, view4]
//    private lazy var viewList = [view1]
    
    private let visibleArea: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.clipsToBounds = true
        return view
    }()
    private let view1: BannerView = {
        let view = BannerView()
        view.configure(leftText: "추석특가1", rightText: "1시간 남았어요", animation: .alarm)
        return view
    }()
    private let view2: BannerView = {
        let view = BannerView()
        view.configure(leftText: "추석특가2", rightText: "32,000원 올라가요", animation: .arrowUp)
        return view
    }()
    private let view3: BannerView = {
        let view = BannerView()
        view.configure(leftText: "추석특가3", rightText: "사실 2시간 남았어요", animation: .alarm)
        return view
    }()
    private let view4: BannerView = {
        let view = BannerView()
        view.configure(leftText: "추석특가4", rightText: "사실 1,000원 올라가요", animation: .arrowUp)
        return view
    }()
    
    private var index = 0
    private var isInitial = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setTimer()
    }
    
    private func setTimer() {
        guard viewList.count > 1 else {
            viewList.first?.snp.updateConstraints { make in
                make.centerY.equalToSuperview()
            }
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            updateLayout(index, isInitial: isInitial)
            index = (index + 1) % viewList.count
            isInitial = false
        }
    }
    
    private func updateLayout(_ index: Int, isInitial: Bool) {
        // 0 1 2 -> 0 1 2 -> 0 1 2 .
        let viewToShow = viewList[safe: index]
        
        // x 0 1 -> 2 0 1 -> 2 0 1 ...
        let editedIndex = index == 0 ? viewList.count - 1 : index - 1
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
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(100)
            }
        }
    }

}

