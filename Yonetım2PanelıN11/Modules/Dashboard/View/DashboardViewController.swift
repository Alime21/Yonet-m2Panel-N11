import UIKit
///UICollectionViewDataSource:bu protokol, ccollection viewda kaç hücre olacağını ve hücrelerin nasıl görüneceğini bildirmek için
class DashboardViewController: UIViewController,  UICollectionViewDataSource {
    ///manuel başlatma,  storyboard kullanmadan, programatik UI yaptığım için
    init() {
        super.init(nibName: nil, bundle: nil)
        print("SearchViewController init() çağrıldı")
    }
    ///viewcontroller dan (coder: ) override'i zorunlu yapsın diye
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("searchviewcontrolller init(coder:) çağrıldı")
    }
    
    ///MVP mimarisinden DashboardPresenter'dan (POP)
    var presenter: DashboardPresenterProtocol?
    
//MARK: UI Elements
    ///profil fotosu
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bmt"))
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    ///profil altındaki text
    private let nameLabel = UILabel.create(text: "B. Mete",
                                           font: .boldSystemFont(ofSize: 24),
                                           color: UIColor(named: "primaryPurple") ?? .black)
    
    ///sayfanın başlığı:  yönetimpaneli
    private let titleLabel: UILabel = {
        let label = UILabel.create(text: "Yönetim Paneli",
                                   font: .systemFont(ofSize: 30, weight: .semibold),
                                   color: UIColor(named: "primaryPurple")!)
        let attributed = NSMutableAttributedString(string: "Yönetim Paneli")
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 34 - label.font.lineHeight
        paragraph.alignment = .left
        attributed.addAttribute(.paragraphStyle, value: paragraph, range: NSRange(location: 0, length: attributed.length))
        label.attributedText = attributed
        return label
    }()
    
    ///yönetim panelinin alt başlığı
    private let subtitleLabel = UILabel.create(text: "n11 Kültür", font: .systemFont(ofSize: 20), color: UIColor(named: "primaryPurple")!)
    
    ///butonlar alt, üst ve ana stackte
    private lazy var topButtonStack = UIStackView.create(axis: .horizontal, spacing: 35, distribution: .fillEqually)
    private lazy var bottomButtonStack = UIStackView.create(axis: .horizontal, spacing: 10, distribution: .equalSpacing)
    private lazy var mainButtonStack = UIStackView.create(axis: .vertical, spacing: 12)
    
    /// galeri başlığı
    private let galleryTitleLabel = UILabel.create(text: "n11 Galeri", font: .boldSystemFont(ofSize: 30), color: UIColor(named: "primaryPurple")!)
    
    ///n11 galeri altındaki görseller
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 15
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(GalleryCell.self, forCellWithReuseIdentifier: GalleryCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        return collection
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier, for: indexPath) as! GalleryCell
            cell.configure(imageName: "glr") /// GalleryCell içinde configure fonksiyonun olmalı
            return cell
    }
    
//MARK: LIFECYCLE: viewcontrollerin oluşturuluşu ve kapanışına kadar olan tüm aşamalr dizisi
    ///ekran ilk yüklendiğinde çalışan fonksiyon
    override func viewDidLoad() {
        super.viewDidLoad()        /// view yülendiğinde (sadxece 1 kere çağrılır), UI kurulumu,veri yükleme
        view.backgroundColor = .white
        collectionView.dataSource = self  /// UICollectionViewDataSource protokolünü uygulamamı sağlar
        presenter?.viewDidLoad()  ///presenter a view yüklendi bilgisi
        
        setupUI()                 ///arayüz elemanları ekrana yerleştirmek için
        setupButtons()
        setupConstraints()        /// UI elemanlarının ekrandaki konumlarını ayarlamaki içn
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()      ///view subviews yerleştiğinde çalışır; frame ve layout ayarlandıktan sonra çağrılır
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let availableWidth = collectionView.bounds.width - layout.sectionInset.left - layout.sectionInset.right - layout.minimumInteritemSpacing
            let cellWidth = availableWidth / 2
            layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 0.7)
        }
    }
//MARK: SETUP METHODS
    private func setupUI() {
        view.addSubviews(
            profileImageView,
            nameLabel,
            titleLabel,
            subtitleLabel,
            mainButtonStack,
            galleryTitleLabel,
            collectionView
        )
        
        mainButtonStack.addArrangedSubview(topButtonStack)
        mainButtonStack.addArrangedSubview(bottomButtonStack)
    }
    
    private func setupButtons() {
        let topButtons = [
            ("Kayıttakiler", "sech 2", UIColor.systemYellow, #selector(kayittakilerTapped)),
            ("Favoriler", "fvr", UIColor.systemPurple, #selector(favoritesButtonTapped)),
            ("Görüntülenenler", "grnt", UIColor.systemYellow, nil)
        ]
        
        topButtons.forEach { title, image, color, action in
            let btn = CircleButtonWithLabel(title: title, imageName: image, backgroundColor: color, size: 80)
            if let action = action { btn.button.addTarget(self, action: action, for: .touchUpInside) }
            topButtonStack.addArrangedSubview(btn)
        }
        
        let bottomButtons = [
            ("Arkadaşlarım", "frnd", UIColor.systemPurple),
            ("Bu Ay Doğanlar", "bday", UIColor.systemPurple)
        ]
        
        bottomButtons.forEach { title, image, color in
            let btn = CircleButtonWithLabel(title: title, imageName: image, backgroundColor: color, size: 80)
            bottomButtonStack.addArrangedSubview(btn)
        }
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 90),
            profileImageView.heightAnchor.constraint(equalToConstant: 90),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            mainButtonStack.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            mainButtonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            galleryTitleLabel.topAnchor.constraint(equalTo: mainButtonStack.bottomAnchor, constant: 24),
            galleryTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            collectionView.topAnchor.constraint(equalTo: galleryTitleLabel.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }

//MARK: Buttons Actions
    @objc func kayittakilerTapped() {
            presenter?.didTapKayıttakiler()          ///ViewController butona basınca -> presenter?.didTapKayıttakiler()
    }
    
    @objc func favoritesButtonTapped() {
        let favoritesVC = FavoritesModuleBuilder.build()
        navigationController?.pushViewController(favoritesVC, animated: true)
    }
    
    /// çıkış yapmak için henüz butonla ilişkili değil sadece tanım
    @objc private func logoutTapped() {}
}
