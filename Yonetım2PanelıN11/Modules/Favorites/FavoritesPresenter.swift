protocol FavoritesPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class FavoritesPresenter: FavoritesPresenterProtocol {
    weak var view: FavoritesViewProtocol?
    var interactor: FavoritesInteractorProtocol?
    var router: FavoritesRouterProtocol?

    func viewDidLoad() {
        interactor?.fetchFavorites()
    }
}

extension FavoritesPresenter: FavoritesInteractorOutputProtocol {
    func didFetchFavorites(_ favorites: [String]) {
        view?.showFavorites(favorites)
    }
}


