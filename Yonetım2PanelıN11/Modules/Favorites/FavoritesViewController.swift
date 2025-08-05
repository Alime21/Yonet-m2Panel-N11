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
        presenter?.viewDidLoad()
    }
}
    


