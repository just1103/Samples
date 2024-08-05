//
//  ViewController.swift
//  Sample_GIF
//
//  Created by 손효주 on 2022/12/06.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private lazy var refreshControl: SimpleRefreshControl = {
        let refreshControl = SimpleRefreshControl()
        refreshControl.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged) // pull 했을 때 할 일
        return refreshControl
    }()
    
    private lazy var mainCollectionView: UICollectionView = {
        let flowLayout = createListFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.refreshControl = refreshControl // 참 쉽죠? activityIndicator와 달리 별도의 start 메서드가 필요 없음
        collectionView.dataSource = self
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: "MainCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
    }
    
    private func createListFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 60.0)
        layout.minimumLineSpacing = 12.0
        layout.minimumInteritemSpacing = 8.0
        return layout
    }
    
    private func configureLayout() {
        view.addSubview(mainCollectionView)
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func pulledToRefresh() {
        print("!!!Refresh!!!")
        
        //        mainViewModel.reset() // ViewModel 통해 API 재요청 (코드 생략)
        didReceiveResponse() // API 호출 완료됨 (가정)
    }
    
    func didReceiveResponse() {
        // ViewModel 통해 API response 확인한 시점에 숨기기 (코드 생략)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in // API 요청 후 3초 뒤 response가 도착함 (가정)
            self?.refreshControl.endRefreshing()
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as? MainCell else {
            return UICollectionViewCell()
        }
        
        cell.setupUI(with: "Cell #\(indexPath.row)")
        
        return cell
    }
}

// MARK: - Cell
final class MainCell: UICollectionViewCell {
    let reuseIndentifier = "MainCell"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        return label
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    func setupUI(with titleText: String) {
        backgroundColor = .darkGray
        titleLabel.text = titleText
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
