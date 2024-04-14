import UIKit

extension UIView {
    func addRoundCorner(to rect: CGRect? = nil, corners: UIRectCorner, radii: CGFloat) {
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(
            roundedRect: rect == nil ? bounds : rect!,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radii, height: radii)
        ).cgPath
        layer.mask = mask
    }
}
