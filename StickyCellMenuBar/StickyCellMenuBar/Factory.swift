import UIKit

struct Factory {
    private(set) lazy var viewModel: ViewModelType = createViewModel()
    private(set) lazy var mediator: ViewModelType = createViewModel()
    
//    func createVC // 이건 여기서는 생략
    
    func createViewModel() -> ViewModelType {
        let vm = ViewModel()
        return vm
    }
    
    func createMediator() -> MediatorType {
        let mediator = Mediator()
        return mediator
    }
    
    func createPageCellModel() {
        
    }
}

protocol MediatorType {
    
}

class Mediator: MediatorType {
    
}
