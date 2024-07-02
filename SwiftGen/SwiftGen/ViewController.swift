import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Color
        view.backgroundColor = UIColor.customPurple
        
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

