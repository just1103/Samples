import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PageCell: UICollectionViewCell {
    
    var currentPageIndex: Int = 0 // viewModel
    
//    private lazy var containerVC = createContainerVC()
    
    private lazy var pageVC = createPageVC()
    private lazy var innerVCs = createInnerVCs()
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        
    }
    
    private func layout() {
        contentView.backgroundColor = .white
        // pageVC addChild 하려면 vc이 필요하구나
        // 최상위 VC에 addChild 해야함
        // inputViewController 이거 안될듯
//        contentView.inputViewController?.addChild(pageVC)
//        pageVC.didMove(toParent: self)
        
        // 아님 필요없음. view만 올리는 느낌으로 써도됨
        contentView.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints { make in
//            make.top.equalTo(menuBar.snp.bottom) // 이게 다른 cell에 있으니까 sticky가 필요한거 아닌가?
//            make.leading.trailing.bottom.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
        // test
        let first = innerVCs[safe: currentPageIndex]!
        pageVC.setViewControllers([first], direction: .forward, animated: false)
    }
    
//    private func createContainerVC() -> UICollectionView {
//        
//    }
    
    private func createPageVC() -> UIPageViewController {
        let view = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        view.dataSource = self
        view.delegate = self
        return view
    }
    
    private func createInnerVCs() -> [UIViewController] {
        let vc1 = UIViewController()
        vc1.view.backgroundColor = .blue
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .green
        
        return [vc1, vc2]
    }
}

// MARK: - UIPageViewController
extension PageCell: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
//        let index = viewModel.output.currentPageIndex.value
        let index = currentPageIndex
        return innerVCs[safe: index - 1]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
//        let index = viewModel.output.currentPageIndex.value
        let index = currentPageIndex
        return innerVCs[safe: index + 1]
    }
}

extension PageCell: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard completed,
              let currentVC = pageVC.viewControllers?.first,
              let index = innerVCs.firstIndex(of: currentVC) else { return }
//        viewModel.input.menuSelected.accept(index)
    }
}
