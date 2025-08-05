import UIKit

/*class UserCell: UICollectionViewCell {
    private let nameLabel = UILabel()
    private let heartIcon = UIImageView()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.backgroundColor = .lightGray
            contentView.layer.cornerRadius = 12
            contentView.clipsToBounds = true

            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            heartIcon.translatesAutoresizingMaskIntoConstraints = false
            heartIcon.tintColor = .red

            contentView.addSubview(nameLabel)
            contentView.addSubview(heartIcon)

            NSLayoutConstraint.activate([
                heartIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                heartIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                heartIcon.widthAnchor.constraint(equalToConstant: 20),
                heartIcon.heightAnchor.constraint(equalToConstant: 20),

                nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }

        required init?(coder: NSCoder) { fatalError() }

        func configure(with user: GitHubUserItem) {
            nameLabel.text = user.login
            heartIcon.image = UIImage(systemName: user.isFavorite ? "heart.fill" : "heart")
        }

        var favoriteButtonAction: (() -> Void)?

        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            let location = touches.first?.location(in: contentView) ?? .zero
            if heartIcon.frame.contains(location) {
                favoriteButtonAction?()
            }
        }
}

*/
