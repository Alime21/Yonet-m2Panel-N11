//GÖRÜNÜM AYARLARI
import UIKit

extension CircleButtonWithLabel {
    func setupUI() {
        configureButton()
        configureLabel()
        configureStack()
    }

    private func configureButton() {
        button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.tintColor = nil
        button.backgroundColor = buttonColor
        button.layer.cornerRadius = size / 2
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureLabel() {
        label.text = title
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureStack() {
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(button)
        stack.addArrangedSubview(label)
        addSubview(stack)
    }
}
