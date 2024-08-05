import UIKit
import SnapKit

public class ClearBackgroundBtn: UIButton {

    public override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            backgroundColor = .clear
            super.isSelected = newValue
        }
    }

    public override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            backgroundColor = .clear
            super.isHighlighted = newValue
        }
    }

    // MARK: - Construction
//    public init() {
//        super.init(frame: .zero)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
}
