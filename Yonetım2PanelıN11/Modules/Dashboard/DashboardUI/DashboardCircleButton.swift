//DashboardViewController daki DashboardCircleButton classı burda
import UIKit
class DashboardCircleButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        backgroundColor = UIColor.systemYellow.withAlphaComponent(0.6)
        setTitleColor(.black, for: .normal)
        layer.cornerRadius = 35
        clipsToBounds = true
        titleLabel?.font = .systemFont(ofSize: 12)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 70).isActive = true
        widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
}
