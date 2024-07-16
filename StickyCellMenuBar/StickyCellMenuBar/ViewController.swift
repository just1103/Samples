import UIKit
import SnapKit
 
class ViewController: UIViewController {

    private let list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    private let stickyIndexPath = IndexPath(row: 1, section: 0) // *index 2번의 cell을 sticky하게 구현
    
    private lazy var collectionView = {
        // flowLayout
//        let layout = CustomFlowLayout(stickyIndexPath: stickyIndexPath)
//        let width = UIScreen.main.bounds.width
//        layout.itemSize = .init(width: width, height: 50)
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 10
//        layout.sectionInset = .init(top: 30, left: 5, bottom: 0, right: 5)
//        layout.scrollDirection = .vertical
        
        // compositionalLayout
        let layout = createCompositionalLayout()
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(MyCell.self, forCellWithReuseIdentifier: "MyCell")
        view.backgroundColor = .systemPink
        
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func createMenuBar() -> MyReviewMenuBar {
        let view = MyReviewMenuBar()
        return view
    }
}

// MARK: - Compositional layout - pinToVisibleBounds 활용
extension ViewController {
    func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            
            if sectionIndex == 1 { // 여기만 sticky하도록 제한 (단, section 2부터는 고정 안됨)
                header.pinToVisibleBounds = true // cell은 안되고 header/footer만 가능
            }
            section.boundarySupplementaryItems = [header]
            
            return section
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // section이 추가되어도 지정한 idx만 sticky함
    func numberOfSections(in tableView: UICollectionView) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? MyCell else {
            return UICollectionViewCell()
        }
        cell.configure(text: "\(indexPath)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        header.backgroundColor = [.black, .white, .green, .blue, .purple, .orange].randomElement()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("@@@ idx", indexPath)
    }
}
