//butonların özellikleri (kayıttakiler,favoriler,geçmiş....)
// Buton + altındaki yazıyı bir arada tutan custom view
import UIKit

public class CircleButtonWithLabel: UIView {
    
    let label: UILabel = UILabel()
    let button: UIButton = UIButton(type: .system)
    let size: CGFloat
    let title: String
    let imageName: String
    let buttonColor: UIColor
    let stack = UIStackView()

    init(title: String, imageName: String, backgroundColor: UIColor, size: CGFloat = 90) {
        self.size = size
        self.title = title
        self.imageName = imageName
        self.buttonColor = backgroundColor
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
                
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder){fatalError("init(coder:) has not been implemented")}
}
