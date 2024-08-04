import UIKit
import Combine

final class KeyboardManager: ObservableObject {

    @Published var keyboardHeight: CGFloat = 0.0
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        Publishers.Merge(
            NotificationCenter.Publisher(
                center: NotificationCenter.default,
                name: UIResponder.keyboardWillShowNotification
            ),
            NotificationCenter.Publisher(
                center: NotificationCenter.default,
                name: UIResponder.keyboardWillChangeFrameNotification
            )
        )
        .throttle(for: .milliseconds(500), scheduler: DispatchQueue.main, latest: false)
        .compactMap { (noti: Notification) -> CGRect in
            noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        }.map { (keyboardFrame :CGRect) -> CGFloat in
            
            print("@@@ 키보드 올라온당 ...", keyboardFrame.height)
            return keyboardFrame.height
        }
        .assign(to: \.keyboardHeight, on: self)
        .store(in: &subscriptions)
//        .subscribe(Subscribers.Assign(object: self, keyPath: \.keyboardHeight))
        
        NotificationCenter.Publisher(
            center: NotificationCenter.default,
            name: UIResponder.keyboardWillHideNotification
        )
        .throttle(for: .milliseconds(500), scheduler: DispatchQueue.main, latest: false)
        .compactMap { _ in
            print("@@@ 키보드 내려간당 ...", 0)
            return .zero
        }
        .assign(to: \.keyboardHeight, on: self)
        .store(in: &subscriptions)
//        .subscribe(Subscribers.Assign(object: self, keyPath: \.keyboardHeight))
    }
    
//    var needsKeyboardHidden: AnyPublisher<Bool, Never> {
//        Publishers.Merge(
//            NotificationCenter.default
//                .publisher(for: UIResponder.keyboardWillShowNotification)
//                .map { _ in return false },
//            NotificationCenter.default
//                .publisher(for: UIResponder.keyboardWillHideNotification)
//                .map { _ in return true }
//        )
//        .eraseToAnyPublisher()
//    }
    
}
