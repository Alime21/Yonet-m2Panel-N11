import UIKit

protocol FavoriViewProtocol: AnyObject {
    func showFavorites(_ favori: [String])
}

class FavoriViewController: UIViewController, FavoriViewProtocol {
    
    var presenter: FavoriViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter?.viewDidLoad()
    }
    
    func showFavori(_ favori: [String]) {
        
    }
}
