import UIKit

protocol SearchViewProtocol: AnyObject {
    func showResults(_ results: [String])
}

class SearchViewController: UIViewController, SearchViewProtocol {
    var presenter: SearchPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter?.viewDidLoad()
    }
    func showResults(_ results: [String]) {
        print("gelen sonuçlar: \(results)")
    }
}
