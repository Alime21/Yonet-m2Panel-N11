//DashboardViewController daki DashboardCircleButton classı burda
//butonların görselleri ve tasarımı
import UIKit
class DashboardCircleButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        backgroundColor = UIColor.systemYellow.withAlphaComponent(0.6)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 12)
        titleLabel?.textAlignment = .center
        
        
        
        layer.cornerRadius = 35
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 70).isActive = true
        widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createButtonWithLabel(title: String, imageName: String) -> UIStackView {
        let button = UIButton()
        button.setImage(UIImage(named: imageName), for: .normal)
        button.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.6)
        button.layer.cornerRadius = 35
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        button.imageView?.contentMode = .scaleAspectFit

        let label = UILabel()
        label.text = title
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.widthAnchor.constraint(equalToConstant: 80).isActive = true // Butonla hizalamak için

        let stack = UIStackView(arrangedSubviews: [button, label])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }
}
