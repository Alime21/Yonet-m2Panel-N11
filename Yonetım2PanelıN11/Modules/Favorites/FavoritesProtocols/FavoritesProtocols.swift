import UIKit

///VİEWCONTROLLER Protocol
protocol FavoritesViewProtocol: AnyObject {
    func showFavorites(_ favorites: [GitHubUserItem])
}

///PRESENTER Protocol
protocol FavoritesPresenterProtocol: AnyObject {
    func viewDidLoad()
}

///INTERACTOR Protocols
protocol FavoritesInteractorProtocol: AnyObject {
    func fetchFavorites()
}

protocol FavoritesInteractorOutputProtocol: AnyObject {
    func didFetchFavorites(_ favorites: [GitHubUserItem])
}

///ROUTER Protocol
protocol FavoritesRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}


