import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private lazy var mainTableView: UITableView = {
        // style plain - header0 높이 0, header 1은 sticky 하도록 구현함
        // (주의 - style grouped은 sticky 하지않음)
        let tableView = UITableView(frame: .zero, style: .plain)
//        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainCell.self, forCellReuseIdentifier: "MainCell")
        tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "CustomHeader")
        tableView.sectionHeaderTopPadding = 0
        tableView.backgroundColor = .systemPink
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Cell
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainCell else {
            return UITableViewCell()
        }
        cell.setupUI(with: "Row \(indexPath.row)")
        return cell
    }
}

// MARK: - Header
extension MainViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 1 else { return nil } // section 1만 sticky
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeader") as? CustomHeader else {
            return UITableViewHeaderFooterView()
        }
        headerView.contentView.backgroundColor = .yellow // headerView backgroundColor 지정
        headerView.setupUI(with: "Section \(section)")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // section 0은 header 없고, section 1은 sticky 하도록 처리
        // section 2부터 불투명 100 높이의 header 영역이 잡힘 (headerView는 안그린 상태일 때 불투명함)
//        if section == 0 {
//            return 0
//        }
//        
//        return 100

        // section 2부터 sticky 풀림 - 노출하는 section 3개 이상일 때 주의
        if section == 1 {
            return 100
        }

        return .zero
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell @ Section \(indexPath.section) Row \(indexPath.row) Tapped")
    }
}
