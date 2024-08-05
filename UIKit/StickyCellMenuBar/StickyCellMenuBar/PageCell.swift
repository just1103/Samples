import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol CellModel {
    var cellType: Cell.Type { get }
}

protocol Cell: UICollectionViewCell {
    var cellModel: CellModel? { get set }
}

extension Cell {
    func commonConfigure() {
//        selectionStyle = .none
        contentView.backgroundColor = .white
    }
}

struct PageCellModel: CellModel {
    var cellType: any Cell.Type
    
    
}

class PageCell: UICollectionViewCell {
    
    var currentPageIndex: Int = 0 // viewModel
    
    // 근데 어차피 menuBar-pageVC 순이고, 상하 스크롤이 아니라 pageVC의 컨텐츠만 바뀌는거라면
    // menuBar가 하위 목록의 bounds를 넘어가지 않아서 sticky header일 필요가 없는 것임
    // 즉, menuBar-pageVC 전체가 1개 cell에 있어도 되는구조
    // + cellModel로 관리
    private lazy var menuBarView = createMenuBarView()
    
    private lazy var pageVC = createPageVC() // 이걸 어케 최상위VC에 넣을까 . . . . .
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
        // pageVC addChild 하려면 vc이 필요하구나 (lifeCycle 관리를 위해 필요함. 최상위 vc에 addChild 필요!)
        // 최상위 VC에 addChild 해야함
        // inputViewController 이거 안될듯
//        contentView.inputViewController?.addChild(pageVC)
//        pageVC.didMove(toParent: self)
        
        contentView.addSubview(menuBarView)
        menuBarView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints { make in
            make.top.equalTo(menuBarView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        // test
        let first = innerVCs[safe: currentPageIndex]!
        pageVC.setViewControllers([first], direction: .forward, animated: false)
    }
    
    private func createMenuBarView() -> MenuBarView {
        let view = MenuBarView()
        return view
    }
    
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
