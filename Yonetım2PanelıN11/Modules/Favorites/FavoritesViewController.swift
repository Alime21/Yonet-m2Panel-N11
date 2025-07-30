import UIKit
protocol FavoritesViewProtocol: AnyObject {
    func showFavorites(_ favorites: [String]) 
}

class FavoritesViewController: UIViewController, FavoritesViewProtocol {

    var presenter: FavoritesPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter?.viewDidLoad()
    }

    func showFavorites(_ favorites: [String]) {
        
    }
}
