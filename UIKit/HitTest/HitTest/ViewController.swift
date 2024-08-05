import UIKit

class ViewController: UIViewController {

    private let label1: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "labelA"
        label.textColor = .black
        label.backgroundColor = .brown
        // view.addSubview(button2)
        // button2.addSubview(label1) 구조
        // isUserInteractionEnabled == false 일 때 - superview인 button2가 탭 제스처 받음
        // isUserInteractionEnabled == true 일 때 - label이 탭 제스처 가로챔. label에 이벤트 연결 안해줘도 가로챔!!! -> superview인 button2가 탭 제스처 못받음!!!
        
        // button2.addSubview(label1) 이면 다른가? 다름!!!
        // isUserInteractionEnabled == false 일 때 - B2개 받음 !!!
        // isUserInteractionEnabled == true 일 때 - B1/B2 둘다 못받음 !!!!!!!!!!!!!!!!
//        label.isUserInteractionEnabled = true // test
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // isUserInteractionEnabled - default 값
    // UILabel - false
    // UIView, UIStackView - true (!!!) 그래서 꺼줘야함
    
    private let label2: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "labelBBBBBBBBBBBB"
        label.textColor = .black
        label.backgroundColor = .black
//        label.isUserInteractionEnabled = true // test
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button1: TestButton1 = {
        let button = TestButton1()
        button.setTitle("111111111111111111111111111111111", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        return button
    }()
    
    private lazy var button2: TestButton2 = {
        let button = TestButton2()
        button.setTitle("22222222222", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        return button
    }()
    
    private lazy var button3: TestButton3 = {
        let button = TestButton3()
        button.setTitle("3333", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.addTarget(self, action: #selector(button3Tapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var button4: TestButton4 = {
        let button = TestButton4()
        button.setTitle("4444", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.addTarget(self, action: #selector(button4Tapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .yellow
        return button
    }()
    
    @objc private func button1Tapped() {
        print("1 ... tapped")
    }
    
    @objc private func button2Tapped() {
        print("2 ... tapped")
    }
    
    @objc private func button3Tapped() {
        print("3 ... tapped")
    }
    
    @objc private func button4Tapped() {
        print("4 ... tapped")
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(button1)
//        view.addSubview(button2)
//        view.addSubview(button3)
        
        button1.addSubview(button4)
        
        button1.addSubview(button2)
        button2.addSubview(label1)
        
        // test 중인거
//        button1.addSubview(label2) // 근데 L2 영역 (B2 아닌거) 탭하면 B1이 이벤트 먹음;;; 이건 왜지
//        view.addSubview(button2) // B2가 이벤트받음 (부모-자식 일 때만 성립) !!!
//        label2.addSubview(button2) // L2 (userEnabled false)가 B2 이벤트 못먹게 막아버림 (부모가 이벤트 못받으면, 자식도 못받아!!!)
        
        NSLayoutConstraint.activate([
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button1.heightAnchor.constraint(equalToConstant: 100),
            
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            button2.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button2.heightAnchor.constraint(equalToConstant: 50),
            
//            button3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            button3.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            
            button4.leadingAnchor.constraint(equalTo: button1.leadingAnchor),
            button4.topAnchor.constraint(equalTo: button1.topAnchor),
            
            label1.leadingAnchor.constraint(equalTo: label1.superview!.leadingAnchor),
            label1.topAnchor.constraint(equalTo: label1.superview!.topAnchor),
            
//            label2.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
//            label2.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            label2.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
}

// 버튼 1 탭했을 때
// 2번 바깥의 1번 영역인데도
// hitTest 상으로 2 -> 1 순으로 불림
//2 ... hitTest - point (-27.666666666666686, 2.999999999999943)
//1 ... hitTest - point (3.3333333333333144, 2.999999999999943)
//2 ... hitTest - point (-27.666666666666686, 2.999999999999943)
//1 ... hitTest - point (3.3333333333333144, 2.999999999999943)
//2 ... hitTest - point (-27.603973388671875, 3.1223347981770644)
//1 ... tapped
class TestButton1: UIButton {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("1 ... hitTest - point", point)
        return super.hitTest(point, with: event)
    }
}

// 버튼 2 탭했을 때
//2 ... hitTest - point (4.666666666666657, 5.333333333333314) <- 2번버튼 bound 기준 탭한 곳의 좌표
//2 ... hitTest - point (4.666666666666657, 5.333333333333314)
//2 ... tapped
class TestButton2: UIButton {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("2 ... hitTest - point", point)
        return super.hitTest(point, with: event)
    }
}

// 다른 뷰와 겹치지 않는 영역이라면?
//3 ... hitTest - point (13.0, 17.333333333333314)
//3 ... hitTest - point (13.0, 17.333333333333314)
//3 ... tapped

// 근데 딴거 탭할 때 3이 왜 불리지? - isInside
// 버튼 바깥 영역 탭할 때도 호출됨 ㅇ-ㅇ
// 3 -> 2 -> 1 순으로
class TestButton3: UIButton {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("3 ... hitTest - point", point)
        return super.hitTest(point, with: event)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let isInside = super.point(inside: point, with: event)
        print("3 ... point - point / isInside", point, isInside)
        return isInside
    }
}

// 만약 1 위에 addSubview로 4를 올리면?
// 3 -> 2 -> 1 -> 4 순으로 불림;
//3 ... hitTest - point (-70.66666666666666, -92.66666666666674)
//2 ... hitTest - point (-81.0, 7.333333333333314)
//1 ... hitTest - point (27.0, 18.0)
//4 ... hitTest - point (27.0, 18.0)
//3 ... hitTest - point (-70.66666666666666, -92.66666666666674)
//2 ... hitTest - point (-81.0, 7.333333333333314)
//1 ... hitTest - point (27.0, 18.0)
//4 ... hitTest - point (27.0, 18.0)
//3 ... hitTest - point (-70.62970987955728, -92.67609659830737)
//2 ... hitTest - point (-80.96304321289062, 7.323903401692689)
//4 ... tapped
class TestButton4: UIButton {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("4 ... hitTest - point", point)
        return super.hitTest(point, with: event)
    }
}
