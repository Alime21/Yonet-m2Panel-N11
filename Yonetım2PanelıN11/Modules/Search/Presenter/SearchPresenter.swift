import Foundation

class SearchPresenter: SearchPresenterProtocol {
    
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorProtocol?
    var router: SearchRouterProtocol?
    
    func performSearch(with query: String) {
        interactor?.search(query: query)
    }
    
    func viewDidLoad() {
        interactor?.fetchAllUsers()
    }
}

///ınteractor dan gelen verileri burda yakalıyor
extension SearchPresenter: SearchInteractorOutputProtocol {
    func didFetchAllUsers(_ users: [GitHubUserItem]) {
        self.view?.showInitialUsers(users)
    }
    
    func didFetchResults(_ results: [GitHubUserItem]) {
        self.view?.showResults(results)
    }
    
    func didFail(_ error: String) {
        self.view?.showError(error)
    }
}
