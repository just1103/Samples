import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let bag = DisposeBag()
    
//    let stream1 = BehaviorSubject<Int>(value: 0)
    let stream1 = BehaviorSubject<Int?>(value: nil)
//    behaviorSubject.onCompleted() // 스트림을 완료함

    // BehaviorRelay 예시
//    let stream2 = BehaviorRelay<Int>(value: 0)
    let stream2 = BehaviorRelay<Int?>(value: nil)

    var num1 = 0
    var num2 = 0
    
    private func test() {
        stream1
            .subscribe(onNext: { num in
                print("1 ...", num)
            }, onCompleted: {
                print("1 ... complete!")
            }).disposed(by: bag)
        
        stream2
            .subscribe(onNext: { num in
                print("2 ...", num)
            }, onCompleted: {
                print("2 ... complete!")
            }).disposed(by: bag)
    }

    // MARK: - Layout
    private lazy var leftButton: UIButton = {
        let action = UIAction { [weak self] _ in self?.leftButtonTapped() }
        let button = UIButton(type: .roundedRect, primaryAction: action)
        button.setTitle("Emit to 1", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var leftButton2: UIButton = {
        let action = UIAction { [weak self] _ in self?.leftButton2Tapped() }
        let button = UIButton(type: .roundedRect, primaryAction: action)
        button.setTitle("Comple to 1", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var rightButton: UIButton = {
        let action = UIAction { [weak self] _ in self?.rightButtonTapped() }
        let button = UIButton(type: .roundedRect, primaryAction: action)
        button.setTitle("Emit to 2", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var rightButton2: UIButton = {
        let action = UIAction { [weak self] _ in self?.rightButton2Tapped() }
        let button = UIButton(type: .roundedRect, primaryAction: action)
        button.setTitle("Comple to 2", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func leftButtonTapped() {
        num1 += 1
        stream1.onNext(num1)
    }
    private func leftButton2Tapped() {
        stream1.onNext(nil) // 안했는데 comple 되는지 테스트
//        stream1.onCompleted()
    }
    
    private func rightButtonTapped() {
        num2 += 1
        stream2.accept(num2)
    }
    private func rightButton2Tapped() {
//        stream2.accept(0)
        stream2.accept(nil)
    }
    
    private func layout() {
        view.addSubview(leftButton)
        view.addSubview(leftButton2)
        view.addSubview(rightButton)
        view.addSubview(rightButton2)
        
        NSLayoutConstraint.activate([
            leftButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            rightButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            leftButton2.topAnchor.constraint(equalTo: leftButton.bottomAnchor, constant: 30),
            leftButton2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            rightButton2.topAnchor.constraint(equalTo: rightButton.bottomAnchor, constant: 30),
            rightButton2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test()
        layout()
    }
}
