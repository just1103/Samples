import UIKit
import SnapKit

// TODO: index 2번의 cell을 sticky하게 구현 
class ViewController: UIViewController {

    private let list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    private let stickyIndexPath = IndexPath(row: 1, section: 0)
    
    private lazy var collectionView = {
        let layout = CustomFlowLayout(stickyIndexPath: stickyIndexPath)
//        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = .init(width: width, height: 50)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 30, left: 5, bottom: 0, right: 5)
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(MyCell.self, forCellWithReuseIdentifier: "MyCell")
        view.backgroundColor = .systemPink
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("@@@ idx", indexPath)
    }
}
