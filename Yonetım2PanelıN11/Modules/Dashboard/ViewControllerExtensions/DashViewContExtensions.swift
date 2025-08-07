import UIKit
//MARK: DashboardViewController'daki extensions
extension UILabel {
    static func create(text: String, font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

extension UIStackView {
    static func create(axis: NSLayoutConstraint.Axis,
                       spacing: CGFloat,
                       distribution: UIStackView.Distribution = .equalSpacing,
                       alignment: UIStackView.Alignment = .center) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.spacing = spacing
        stack.distribution = distribution
        stack.alignment = alignment
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
}

