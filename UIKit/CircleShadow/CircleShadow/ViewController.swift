import UIKit
import SnapKit

class ViewController: UIViewController {

    private let shadowedView = ShadowedView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(updatePosition))
        shadowedView.addGestureRecognizer(tapGR)
        view.addSubview(shadowedView)
        
        shadowedView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
    
    @objc private func updatePosition() {
        shadowedView.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(300)
            make.width.height.equalTo(100)
        }
    }

}
