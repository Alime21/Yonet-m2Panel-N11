protocol FavoriPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class FavoriPresenter: FavoriPresenterProtocol {
    weak var view: FavoriViewProtocol?
    var interactor: FavoriInteractorProtocol?
    var router: FavoriRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchFavori()
    }
}

extension FavoriPresenter: FavoriInteractorOutputProtocol {
    func didFetchFavori(_ favori: [String]) {
        view?.showFavorites(<#T##favori: [String]##[String]#>)
    }
}

