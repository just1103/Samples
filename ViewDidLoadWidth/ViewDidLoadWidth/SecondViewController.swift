import UIKit
import SnapKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2. push된 vc인 경우 (storyboard 사용) :
        // viewDidLoad 시점에 부정확한 width (= storyboard에서 설정된 기기의 width)가 반환됨 
        print("viewDidLoad ...", view.frame.size.width)
        showBottomSheet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear ...", view.frame.size.width)
//        showBottomSheet()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews ...", view.frame.size.width)
//        showBottomSheet()
    }

    private func showBottomSheet() {
        let bottomSheetView = HomeBottomSheetView()
        
        view.addSubview(bottomSheetView)
        bottomSheetView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bottomSheetView.show()
        
        print("BottomSheet Width              ...", bottomSheetView.bounds.width)
        print("BottomSheet contentView Width  ...", bottomSheetView.contentView.bounds.width)
        print("BottomSheet contentView Height ...", bottomSheetView.contentView.bounds.height)
    }
    
}
