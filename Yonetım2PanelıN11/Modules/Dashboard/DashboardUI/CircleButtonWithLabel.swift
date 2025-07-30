//butonların özellikleri

// 1. Buton + altındaki yazıyı bir arada tutan custom view
import UIKit
public class CircleButtonWithLabel: UIView {
    
    let label: UILabel = UILabel()
    let button: UIButton = UIButton(type: .system)

    init(title: String, imageName: String, backgroundColor: UIColor, size: CGFloat = 90) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        // Button ayarları
        //let button: UIButton = UIButton(type: .system)
        button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.tintColor = nil
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = size / 2
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false

        // Label ayarları
        label.text = title
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false

        // StackView: Buton ve label dikey olarak
        let stack = UIStackView(arrangedSubviews: [button, label])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),

            button.widthAnchor.constraint(equalToConstant: size),
            button.heightAnchor.constraint(equalToConstant: size),
            label.widthAnchor.constraint(equalTo: button.widthAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
