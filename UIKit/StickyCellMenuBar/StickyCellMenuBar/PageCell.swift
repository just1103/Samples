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
    
    // viewModel
    var currentPageIndex: Int = 0 {
        didSet {
            menuBarView.setSelectedIndex(to: currentPageIndex)
        }
    }
    
    // 근데 어차피 menuBar-pageVC 순이고, 상하 스크롤이 아니라 pageVC의 컨텐츠만 바뀌는거라면
    // menuBar가 하위 목록의 bounds를 넘어가지 않아서 sticky header일 필요가 없는 것임
    // 즉, menuBar-pageVC 전체가 1개 cell에 있어도 되는구조
    // + cellModel로 관리
    private lazy var menuBarView = createMenuBarView()
    
    // 이걸 어케 최상위VC에 넣을까.. factory에서 정리해서 반환해주면 좋겠다
    private lazy var pageVC = createPageVC()
    private lazy var innerVCs = createInnerVCs()
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        // TODO: menuBar label 탭하면 currentPageIndex 바꿔주기
    }
    
    private func layout() {
        contentView.backgroundColor = .white

        contentView.addSubview(menuBarView)
        menuBarView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints { make in
            make.top.equalTo(menuBarView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        // TODO: pageVC도 최상위 PV에 addChild 해야하는데 일단 생략 (lifeCycle 관리해야해서)
        innerVCs.forEach {
            pageVC.addChild($0)
            $0.didMove(toParent: pageVC)
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
        view.view.backgroundColor = .lightGray
        return view
    }
    
    private func createInnerVCs() -> [UIViewController] {
        let vc0 = UIViewController()
        vc0.view.backgroundColor = .orange
        
        let vc1 = ProductListVC()
        vc1.view.backgroundColor = .green
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .blue
        
        return [vc0, vc1, vc2]
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
        currentPageIndex = index
        return innerVCs[safe: index - 1]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
//        let index = viewModel.output.currentPageIndex.value
        let index = currentPageIndex
        currentPageIndex = index
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
        currentPageIndex = index
    }
}
