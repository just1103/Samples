import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxRelay
import RxKeyboard

class ViewController: UIViewController {

    private lazy var textField: UITextField = {
        let view = UITextField(frame: .zero)
        view.placeholder = "입력 . . ."
        view.backgroundColor = .yellow
        return view
    }()
    
    private lazy var mainTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainCell.self, forCellReuseIdentifier: "MainCell")
        tableView.backgroundColor = .systemPink
        tableView.keyboardDismissMode = .onDrag
        tableView.contentInset = .zero
        return tableView
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
    }

    private func bind() {
        RxKeyboard.instance.isHidden
            .skip(1)
            .filter { $0 }
            .drive(onNext: { [weak self] isHidden in
                print("@@@ !!! keyboard isHidden", isHidden)
                guard let self else { return }
                mainTableView.contentInset = .zero // 다시 위로 올려주려면 필요함 
            }).disposed(by: disposeBag)

        RxKeyboard.instance.willShowVisibleHeight
            .drive { [weak self] height in
                guard let self else { return }
                print("@@@ !!! willShowVisibleHeight", height)
//                mainTableView.contentOffset.y += height // 됨
                
                mainTableView.contentInset.bottom = height // 안되는거 같지만 적용된거임
                mainTableView.scrollToRow(at: .init(row: 19, section: 0), at: .bottom, animated: true) // 이거 해줘야함
            }.disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
            .drive { [weak self] height in
                guard let self else { return }
                print("@@@ !!! visibleHeight", height)
//                mainTableView.contentInset.bottom = height // 안되는거 같지만 적용된거임
//                mainTableView.scrollToRow(at: .init(row: 19, section: 0), at: .bottom, animated: true) // 이거 해줘야함
            }.disposed(by: disposeBag)
    }
    
    private func layout() {
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell @ Section \(indexPath.section) Row \(indexPath.row) Tapped")
    }
}
