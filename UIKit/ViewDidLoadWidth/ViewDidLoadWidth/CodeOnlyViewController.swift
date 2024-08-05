import UIKit
import SnapKit

class CodeOnlyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        
        // 3. push된 vc인 경우 (storyboard 미사용) :
        // viewDidLoad 시점에 정확한 width (= 현재 실행중인 기기의 width)가 계산됨
        print("viewDidLoad (code only)...", view.frame.size.width)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear (code only)...", view.frame.size.width)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews (code only)...", view.frame.size.width)
    }
    
}
