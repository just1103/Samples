import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. initial vc인 경우 :
        // viewDidLoad에서 width가 제대로 잡힘
        print("viewDidLoad (main) ...", view.frame.size.width)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let secondVC = SecondViewController()
        navigationController?.pushViewController(secondVC, animated: true)
        
//        let codeOnlyVC = CodeOnlyViewController()
//        navigationController?.pushViewController(codeOnlyVC, animated: true)
    }
    
}
