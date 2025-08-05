protocol FavoritesInteractorProtocol: AnyObject {
    func fetchFavorites()
}

protocol FavoritesInteractorOutputProtocol: AnyObject {
    func didFetchFavorites(_ favorites: [String])
}

class FavoritesInteractor: FavoritesInteractorProtocol {
    weak var output: FavoritesInteractorOutputProtocol?

    func fetchFavorites() {
        // Burada API veya local DB'den veri çekilir
        /*let favorites = FavoritesManager.shared.getFavorites()
        output?.didFetchFavorites(favorites)*/
        
        let dummyFavorites = ["Ürün 1", "Ürün 2"]
        output?.didFetchFavorites(dummyFavorites)
        

    }
}
