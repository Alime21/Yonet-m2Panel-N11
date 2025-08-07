import UIKit
import Kingfisher

class UserCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private let avatarButton : UIButton = {
        let avatarButton = UIButton()
        // Avatar Button
        avatarButton.translatesAutoresizingMaskIntoConstraints = false
        avatarButton.clipsToBounds = true
        avatarButton.layer.cornerRadius = 12
        avatarButton.imageView?.contentMode = .scaleAspectFill
        avatarButton.isUserInteractionEnabled = false
        return avatarButton
    }()
    
    private let favoriteButton : UIButton = {
        let favoriteButton = UIButton()
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = .red
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        return favoriteButton
    }()

    // MARK: - Data
    var userName: String = ""
    var avatarURL: String = ""
    var favoriteButtonAction: (() -> Void)?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Setup
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
 
        // Add to contentView
        contentView.addSubview(avatarButton)
        contentView.addSubview(nameLabel)
        contentView.addSubview(favoriteButton)
    }

   // MARK: - Configuration
    func configure(with user: GitHubUserItem) {
        nameLabel.text = user.login
        userName = user.login
        avatarURL = user.avatar_url

        if let url = URL(string: user.avatar_url) {
            avatarButton.kf.setBackgroundImage(with: url, for: .normal)
        }

        let heartImageName = FavoriteManager.shared.isFavorite(username: user.login) ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: heartImageName), for: .normal)
    }

    // MARK: - Actions
    @objc private func favoriteTapped() {
        guard let username = nameLabel.text else { return }
        let isFavorite = FavoriteManager.shared.isFavorite(username: username)

        if isFavorite {
            FavoriteManager.shared.removeFavorite(username: username)
        } else {
            let user = GitHubUserItem(login: username, avatar_url: avatarURL)
            FavoriteManager.shared.addFavorite(user: user)
        }

        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            UIView.transition(with: favoriteButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
                let imageName = isFavorite ? "heart" : "heart.fill"
                self.favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
            })
        }

        favoriteButtonAction?()
    }
}

extension UserCell {
    func setupConstraints() {
           setupAvatarButtonConstraints()
           setupNameLabelConstraints()
           setupFavoriteButtonConstraints()
       }
    
    func setupAvatarButtonConstraints() {
        NSLayoutConstraint.activate([
            avatarButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: avatarButton.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func setupFavoriteButtonConstraints() {
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
