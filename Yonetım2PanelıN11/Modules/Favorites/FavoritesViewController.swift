import UIKit
protocol FavoritesViewProtocol: AnyObject {
    func showFavorites(_ favorites: [String])
}

class FavoritesViewController: UIViewController, FavoritesViewProtocol {
    func showFavorites(_ favorites: [String]) {
    
    }
    
    
    var presenter: FavoritesPresenterProtocol?
    /// favorileri tutan array
 //   var users: [GitHubUserItem] = []
    
  /*  private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 150)
        layout.scrollDirection = .vertical
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }() */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //title = "Favoriler"
        
       /* collectionView.dataSource = self
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: "UserCell")
        collectionView.frame = view.bounds
        view.addSubview(collectionView)  */
        
        presenter?.viewDidLoad()
    }
    
   /* func showFavorites(_ favorites: [GitHubUserItem]) {
       self.users = favorites
        collectionView.reloadData()
        
    } */
}
    
/* extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath) as? UserCell else {
            return UICollectionViewCell()
        }
        
        let user = users[indexPath.item]
        cell.configure(with: user) // UserCell içinde configure fonksiyonun olmalı
        return cell
    }
} */

