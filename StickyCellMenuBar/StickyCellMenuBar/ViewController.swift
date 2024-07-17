import UIKit
import SnapKit
import RxSwift
import RxCocoa
 
class ViewController: UIViewController {

    private let stickyIndexPath = IndexPath(row: 1, section: 0) // *index 2번의 cell을 sticky하게 구현
    
    private lazy var naviBar = createNaviBar()
    private lazy var collectionView = createCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        view.addSubview(naviBar)
        naviBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view)
        }
    }
    
    private func createNaviBar() -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }
    
    private func createCollectionView() -> UICollectionView {
        // flowLayout
//        let layout = CustomFlowLayout(stickyIndexPath: stickyIndexPath)
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true // 모든 header를 고정
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
//        layout.sectionInset = .init(top: 30, left: 5, bottom: 0, right: 5)
        
        // compositionalLayout
//        let layout = createCompositionalLayout()
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
//        view.backgroundColor = .systemPink
        view.register(MyCell.self, forCellWithReuseIdentifier: "MyCell")
        view.register(PageCell.self, forCellWithReuseIdentifier: "PageCell")
        view.register(MyHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeader")
        return view
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in tableView: UICollectionView) -> Int {
       2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 10
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? MyCell else {
                return UICollectionViewCell()
            }
            cell.configure(text: "\(indexPath)")
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCell", for: indexPath) as? PageCell else {
                return UICollectionViewCell()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyHeader", for: indexPath) as? MyHeader else {
            return UICollectionReusableView()
        }
        
        // 탭 이벤트 연결
//        header.view.firstLabel
//        
//        header.view.secondLabel
//        header.view.thirdLabel
//        header.view.setSelectedIndex(to: <#T##Int#>) // pageVC이랑 연결
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        if indexPath.section == 0 {
            return .init(width: width, height: 100) // TODO: estimated로 되는지 체크
        } else {
            return .init(width: width, height: 800)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return .zero
        } else {
            let width = UIScreen.main.bounds.width
            return .init(width: width, height: 52)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("@@@ idx", indexPath)
    }
}

// MARK: - Compositional layout - pinToVisibleBounds 활용
//extension ViewController {
//    func createCompositionalLayout() -> UICollectionViewLayout {
//        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
//            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//
//            let section = NSCollectionLayoutSection(group: group)
//
//            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
//            let header = NSCollectionLayoutBoundarySupplementaryItem(
//                layoutSize: headerSize,
//                elementKind: UICollectionView.elementKindSectionHeader,
//                alignment: .top
//            )
//
//            if sectionIndex == 1 { // 여기만 sticky하도록 제한 (단, section 2부터는 고정 안됨)
//                header.pinToVisibleBounds = true // cell은 안되고 header/footer만 가능
//            }
//            section.boundarySupplementaryItems = [header]
//
//            return section
//        }
//    }
//}
