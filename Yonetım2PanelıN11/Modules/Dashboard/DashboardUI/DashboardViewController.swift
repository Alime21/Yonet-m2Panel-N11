import UIKit

//UICollectionViewDataSource:bu protokol, ccollection viewda kaç hücre olacağını ve hücrelerin nasıl görüneceğini bildirmek için
class DashboardViewController: UIViewController, UICollectionViewDataSource {
    
    //manuel başlatma
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    //MVP mimarisinden DashboardPresenter'dan (POP)
    var presenter: DashboardPresenterProtocol?
    
//B. Mete kısmı
    //yuvarlak kullanıcı profil fotosu
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bmt"))
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    //kullanıcı adı
    private let nameLabel: UILabel = {
            let label = UILabel()
            label.text = "B. Mete"
            label.font = .boldSystemFont(ofSize: 24)
            label.textColor = UIColor(red: 86/255.0, green: 57/255.0, blue: 172/255.0, alpha: 1.0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
//B.Mete bitiş
    
//sayfa başlığı yönetimpaneli
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Yönetim Paneli"
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = UIColor(red: 86/255.0, green: 57/255.0, blue: 172/255.0, alpha: 1.0)
        
        let attributedString = NSMutableAttributedString(string: "Yönetim Paneli")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 34 - label.font.lineHeight
        paragraphStyle.alignment = .left
        
        // Letter spacing (0px - default)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length:attributedString.length))
        attributedString.addAttribute(.kern, value: 0.0, range: NSRange(location: 0, length: attributedString.length))
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()
    
    //alt başlık
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "n11 Kültür"
        label.font = .systemFont(ofSize: 20)
        label.textColor = UIColor(red: 86/255.0, green: 57/255.0, blue: 172/255.0, alpha: 1.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
//sayfa başlığı yönetimpaneli BİTİŞ
    

//STACK İÇİNDE BUTOMLAR 3 E 2
    private let topButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 35
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let bottomButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .equalSpacing // Ortalamak için
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let mainButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
//STACK butonlar BİTİŞ
    
    
//galeri başlığı VE GALERİ BAŞLANGIÇ KISMI
    private let galleryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "n11 Galeri"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = UIColor(red: 86/255.0, green: 57/255.0, blue: 172/255.0, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // collectionview da 6 hücre var
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    //herbir hücrenin görünümü ve adı da GalleryCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier, for: indexPath) as! GalleryCell
        cell.configure(imageName: "glr")
        return cell
    }
    //galeriyi yatay göstermek için
    private let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 20, height: 10)
            layout.minimumInteritemSpacing = 3
            layout.minimumLineSpacing = 15
            

            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.register(GalleryCell.self, forCellWithReuseIdentifier: "GalleryCell")
            collection.translatesAutoresizingMaskIntoConstraints = false
            collection.backgroundColor = .white
            return collection
    }()
//GALERİ BİTİŞ
    
    
    //ekran ilk yüklendiğinde çalışan fonksiyon
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.dataSource = self
        presenter?.viewDidLoad()  //presenter a view yüklendi bilgisi
        setupUI()                 //arayüz elemanları ekrana yerleştirmek için
    }
    
   
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let availableWidth = collectionView.bounds.width - layout.sectionInset.left - layout.sectionInset.right - layout.minimumInteritemSpacing
            let cellWidth = availableWidth / 2
            layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 0.7)
        }
    }
    
//kayıttakiler butonuna basınca search sayfasına gidebilsin diye:
//ViewController butona basınca -> presenter?.didTapKayıttakiler()
    @objc func kayittakilerTapped() {
// *** butona basınca search sayfası açılsın diye:
            let vc = SearchViewController()
            vc.view.backgroundColor = .white
            navigationController?.pushViewController(vc, animated: true)
// ***
           if presenter == nil {
               print("Presenter nil, bağlantı yok!")
           } else {
               presenter?.didTapKayıttakiler()
           }
    }
    
// favoriler butonuna basınca
    @objc func favoritesButtonTapped() {
        let favoritesVC = FavoritesModuleBuilder.build()
        navigationController?.pushViewController(favoritesVC, animated: true)
        
        if presenter == nil {
            print("dd")
        }else {
            presenter?.didTapFavorites()
        }
    }
//
    
    //tüm UI elemanlarını ekrana yerleştirmek için
    private func setupUI() {
            view.addSubview(profileImageView)
            view.addSubview(nameLabel)
            view.addSubview(titleLabel)
            view.addSubview(subtitleLabel)
            view.addSubview(topButtonStack)
            view.addSubview(bottomButtonStack)
            view.addSubview(mainButtonStack)
            view.addSubview(galleryTitleLabel)
            view.addSubview(collectionView)
            
        

    // Butonlar
        mainButtonStack.addArrangedSubview(topButtonStack)
        mainButtonStack.addArrangedSubview(bottomButtonStack)
        let topButtons: [(title: String, imageName: String,color: UIColor)] = [
            ("Kayıttakiler", "sech 2",UIColor.systemYellow),
            ("Favoriler","fvr",UIColor.systemPurple),
            ("Görüntülenenler","grnt",UIColor.systemYellow)
            ]
        
            for item in topButtons {
                let buttonWithLabel = CircleButtonWithLabel(title: item.title, imageName: item.imageName,backgroundColor:item.color, size:80)
            
                
                // kayıttakiler butonu
                if item.title == "Kayıttakiler" {
                    buttonWithLabel.button.addTarget(self, action:  #selector(kayittakilerTapped), for: .touchUpInside)
                }
                else if item.title == "Favoriler" {
                    buttonWithLabel.button.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
                }
                topButtonStack.addArrangedSubview(buttonWithLabel)
            }
        
        let bottomButtons: [(title: String, imageName: String,color: UIColor)] = [
            ("Arkadaşlarım", "frnd",UIColor.systemPurple),
            ("Bu Ay Doğanlar","bday",UIColor.systemPurple)
            ]
        
            for item in bottomButtons {
                let buttonWithLabel = CircleButtonWithLabel(title: item.title, imageName: item.imageName, backgroundColor: item.color,size: 80)
                bottomButtonStack.addArrangedSubview(buttonWithLabel)
            }
        
        topButtonStack.axis = .horizontal
        topButtonStack.spacing = 35
        topButtonStack.distribution = .equalSpacing
        topButtonStack.alignment = .center
        topButtonStack.translatesAutoresizingMaskIntoConstraints = false
     
        bottomButtonStack.axis = .horizontal
        bottomButtonStack.spacing = 35
        bottomButtonStack.distribution = .equalSpacing
        bottomButtonStack.alignment = .center
        bottomButtonStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
                   profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                   profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor), //Ortala
                   profileImageView.widthAnchor.constraint(equalToConstant: 90),
                   profileImageView.heightAnchor.constraint(equalToConstant: 90),

                   nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
                   nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor), //Ortala

                   titleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
                   titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15), // left: 15px
                   titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                
        
                   subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                   subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                   subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
                   
                   
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
    
    
    
    
    
   // çıkış yapmak için henüz butonla ilişkili değil sadece tanım
    @objc private func logoutTapped() {
//        presenter?.logout()
    }
}
