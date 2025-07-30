import Foundation

protocol SearchPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class SearchPresenter: SearchPresenterProtocol {
    
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorProtocol?
    var router: SearchRouterProtocol?
    
    func viewDidLoad() {
        print("search ekranı açıldıf")
        interactor?.fetchSearchResults()
    }
}

//ınteractor dan gelen çıktıları burda yakalıyor
extension SearchPresenter: SearchInteractorOutputProtocol {
    func didFetchResults(_ results: [String]) {
        view?.showResults(results)
    }
}
