import UIKit

class FavoritesViewController: UIViewController, FavoritesViewProtocol {
    
    var presenter: FavoritesPresenterProtocol?
    var favoriteUsers: [GitHubUserItem] = []

    ///favori kullanıcıları gösteren UICollectionview
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 150)
        layout.scrollDirection = .vertical
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: "UserCell")
        collectionView.frame = view.bounds
        presenter?.viewDidLoad()
    }
    
    func showFavorites(_ favorites: [GitHubUserItem]) {
        self.favoriteUsers = favorites
        collectionView.reloadData()
    }
}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    /// kaç tane hücre olacak: favori kullanıcı sayısı kadar
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteUsers.count
    }
    
    ///hücre oluşturdum adı usercell; configure ile kullancı bilgisini hücreye verdim
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath) as? UserCell else {
            return UICollectionViewCell()
        }
        let user = favoriteUsers[indexPath.row]
        cell.configure(with: user)
        
        /// hücredeki kalp butonuna basınca o kullanıcıyı favoriden çıkar; Manager dan sil; reload: güncelle
        cell.favoriteButtonAction = { [weak self] in
            guard let self else { return }
            self.favoriteUsers.removeAll { $0.login == user.login }
            FavoriteManager.shared.removeFavorite(username: user.login)
            self.collectionView.reloadData()
        }
        return cell
    }
}


    


