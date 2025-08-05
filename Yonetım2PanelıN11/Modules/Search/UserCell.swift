import UIKit
import Kingfisher

class UserCell: UICollectionViewCell {
    
    private let nameLabel = UILabel()
    private let avatarButton = UIButton()  // Kullanıcının avatarı burada gösterilecek (arka plan olarak)
    private let favoriteButton = UIButton(type: .system) // Kalp butonu
    var userName: String = ""
    
    var favoriteButtonAction: (() -> Void)? // Callback
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true

        nameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        avatarButton.translatesAutoresizingMaskIntoConstraints = false
        avatarButton.clipsToBounds = true
        avatarButton.layer.cornerRadius = 12
        avatarButton.imageView?.contentMode = .scaleAspectFill
        avatarButton.isUserInteractionEnabled = false // Sadece görsel amaçlı

        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = .red
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)

        contentView.addSubview(avatarButton)
        contentView.addSubview(nameLabel)
        contentView.addSubview(favoriteButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            avatarButton.heightAnchor.constraint(equalTo: avatarButton.widthAnchor), // Kare yap

            nameLabel.topAnchor.constraint(equalTo: avatarButton.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    func configure(with user: GitHubUserItem) {
        nameLabel.text = user.login

        if let url = URL(string: user.avatar_url) {
            avatarButton.kf.setBackgroundImage(with: url, for: .normal)
        }

        let heartImageName = user.isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: heartImageName), for: .normal)
    }

    @objc private func favoriteTapped() {
        let isFavorite = FavoriteManager.shared.isFavorite(username: nameLabel.text ?? "")
        if isFavorite {
            FavoriteManager.shared.removeFavorite(username: nameLabel.text ?? "")
            UIView.transition(with: favoriteButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
                let imageName = isFavorite ? "heart" : "heart.fill"
                self.favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
            })
        } else {
            FavoriteManager.shared.addFavorite(username: nameLabel.text ?? "")
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                UIView.transition(with: favoriteButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    let imageName = isFavorite ? "heart" : "heart.fill"
                    self.favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
                })
            }
        }
    }
}
