import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Color
        view.backgroundColor = UIColor.customPurple
        
        // Finder의 파일을 Xcode로 드래그앤드롭 하면 이렇게 쓸 수 있음
        // 안하면 못찾음
//        view.backgroundColor = Asset.Colors.customPurple.color
        
        // Image
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.iconSettingP5.withTintColor(.white), for: .normal)
        button.setImage(UIImage.iconDoneP5.withTintColor(.white), for: .selected)
        button.addAction(UIAction { action in
            guard let btn = action.sender as? UIButton else { return }
            btn.isSelected = !btn.isSelected
        }, for: .touchUpInside)
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 50),
            button.heightAnchor.constraint(equalToConstant: 50),
        ])
    }


}
