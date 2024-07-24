import UIKit
import RxSwift
import RxCocoa
import RxRelay
import SnapKit

class ViewController: UIViewController {

    var currentIndex = 0 {
        didSet {
            menuBar.setSelectedIndex(to: currentIndex)
            if let vc = innerVCs[safe: currentIndex] {
                pageVC.setViewControllers([vc], direction: .forward, animated: false)
            }
        }
    }
    
    private var menuBar = MenuBar()
    private lazy var pageVC: UIPageViewController = createpageVC()
    private lazy var innerVCs: [UIViewController] = {
        let vc0 = UIViewController()
        vc0.view.backgroundColor = .red
        let vc1 = UIViewController()
        vc1.view.backgroundColor = .orange
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .green
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .blue
        return [vc0, vc1, vc2, vc3]
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(pageVC)
        pageVC.didMove(toParent: self)
        
        layout()
        bind()
        
        menuBar.setSelectedIndex(to: currentIndex)
        pageVC.setViewControllers([innerVCs[currentIndex]], direction: .forward, animated: false)
    }
    
    private func layout() {
        view.addSubview(menuBar)
        menuBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints { make in
            make.top.equalTo(menuBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func bind() {
        menuBar.buttons.enumerated().forEach { (index, label) in
            label.rx.tap
                .map { _ in index }
                .bind { [weak self] index in
                    guard let self else { return }
                    print("@@@ input - menuSelected ...", index)
                    currentIndex = index 
                }
                .disposed(by: disposeBag)
        }
    }

    private func createpageVC() -> UIPageViewController {
        let view = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        view.dataSource = self
        view.delegate = self
        return view
    }
    
}

// MARK: - UIPageViewController
extension ViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = innerVCs.firstIndex(of: viewController)
        else {
            return nil
        }
        print("@@@ Before ... index", index - 1)
        return innerVCs[safe: index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = innerVCs.firstIndex(of: viewController)
        else {
            return nil
        }
        print("@@@ After ... index", index + 1)
        return innerVCs[safe: index + 1]
    }
}

extension ViewController: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageVC: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard completed,
              let currentVC = pageVC.viewControllers?.first,
              let index = innerVCs.firstIndex(of: currentVC) else { return }
        print("@@@ didFinishAnimating ...", index)
//        currentIndex = index // FIXME: 간헐적으로 flushedVC 관련 크래시 발생, 스크롤 시 화면이 정확히 안잡히는 문제
//        didFinishAnimating 메서드 내부에서 pageVC.setViewController를 호출하면 안되는듯
        
        menuBar.setSelectedIndex(to: index)
    }
}
