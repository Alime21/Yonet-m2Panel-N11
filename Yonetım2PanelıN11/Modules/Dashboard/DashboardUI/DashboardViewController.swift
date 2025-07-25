import UIKit

class DashboardViewController: UIViewController, UICollectionViewDataSource {
    
    // 78.satırdaki viewdidloaddaki self hata verdiği için ekledim 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier, for: indexPath) as! GalleryCell
        cell.configure(imageName: "exampleImage")
        return cell
    }
    
    //loginRouterdaki "Missing argument for parameter 'coder' in call" hatası için
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
    var presenter: DashboardPresenterProtocol?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"profile")
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let nameLabel: UILabel = {
            let label = UILabel()
            label.text = "B. Mete"
            label.font = .boldSystemFont(ofSize: 18)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Yönetim Paneli"
        label.font = .systemFont(ofSize: 22,weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "n11 Kültür"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let galleryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "n11 Galeri"
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 100, height: 80)
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 8

            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.register(GalleryCell.self, forCellWithReuseIdentifier: "GalleryCell")
            collection.translatesAutoresizingMaskIntoConstraints = false
            return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.dataSource = self
        presenter?.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
            view.addSubview(profileImageView)
            view.addSubview(nameLabel)
            view.addSubview(titleLabel)
            view.addSubview(subtitleLabel)
            view.addSubview(buttonStackView)
            view.addSubview(galleryTitleLabel)
            view.addSubview(collectionView)

            // Butonlar
            let buttonTitles = ["İçerik", "Favoriler", "Görseller", "Geri Bildirim"]
            for title in buttonTitles {
                let button = DashboardCircleButton(title: title)
                buttonStackView.addArrangedSubview(button)
            }
        NSLayoutConstraint.activate([
                   profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                   profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                   profileImageView.widthAnchor.constraint(equalToConstant: 60),
                   profileImageView.heightAnchor.constraint(equalToConstant: 60),

                   nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
                   nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),

                   titleLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
                   titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

                   subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                   subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

                   buttonStackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
                   buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                   buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                   buttonStackView.heightAnchor.constraint(equalToConstant: 80),

                   galleryTitleLabel.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 20),
                   galleryTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

                   collectionView.topAnchor.constraint(equalTo: galleryTitleLabel.bottomAnchor, constant: 12),
                   collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                   collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                   collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
               ])
           }
    
    
    @objc private func logoutTapped() {
//        presenter?.logout()
    }
}
