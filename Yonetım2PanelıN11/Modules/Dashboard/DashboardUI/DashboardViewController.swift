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
        label.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
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
        label.font = .systemFont(ofSize: 24)
        label.textColor = UIColor(red: 86/255.0, green: 57/255.0, blue: 172/255.0, alpha: 1.0)
        label.textAlignment = .center
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
        label.font = .boldSystemFont(ofSize: 40)
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
            let topButtons: [(title: String, imageName: String)] = [
                ("Kayıttakiler", "sech 2"),
                ("Favoriler","fvr"),
                ("Görüntülediklerim","grnt")
            ]
            for item in topButtons {
                let button = DashboardCircleButton(title: item.title)
                button.setImage(UIImage(named: item.imageName), for: .normal)
                button.imageView?.contentMode = .scaleAspectFit
                topButtonStack.addArrangedSubview(button)
            }
            let bottomButtons: [(title: String, imageName: String)] = [
                ("Arkadaşlarım", "frnd"),
                ("Bu Ay Doğanlar","bday")
            ]
            for item in bottomButtons {
                let button = DashboardCircleButton(title: item.title)
                button.setImage(UIImage(named: item.imageName), for:.normal)
                button.imageView?.contentMode = .scaleAspectFit
                bottomButtonStack.addArrangedSubview(button)
            }
        
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
                   subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
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
