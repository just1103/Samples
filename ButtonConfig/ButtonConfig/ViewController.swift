import UIKit

class ViewController: UIViewController {
    
    let btn: UIButton = {
//        let view = UIButton(frame: .zero)
        let view = UIButton(type: .custom) // 이거하면 selected 일때 background 안바뀜
//        let view = ClearBackgroundBtn(type: .custom)
        view.setImage(UIImage(systemName: "plus")?.withTintColor(.green), for: .normal)
        view.setImage(UIImage(systemName: "person")?.withTintColor(.orange), for: .selected)
        view.tintColor = .red
//        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .lightGray
        
        btn.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            btn.isSelected = !btn.isSelected
        }), for: .touchUpInside)
        
        view.addSubview(btn)
        NSLayoutConstraint.activate([
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            btn.widthAnchor.constraint(equalToConstant: 200),
            btn.heightAnchor.constraint(equalToConstant: 200),
        ])
        
    }
}

