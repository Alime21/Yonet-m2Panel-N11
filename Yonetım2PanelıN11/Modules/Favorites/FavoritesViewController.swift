import UIKit
protocol FavoritesViewProtocol: AnyObject {
    func showFavorites(_ favorites: [String])
}

class FavoritesViewController: UIViewController, FavoritesViewProtocol {
   func showFavorites(_ favorites: [String]) {}
    
    var presenter: FavoritesPresenterProtocol?
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        presenter?.viewDidLoad()
    }
}


    


