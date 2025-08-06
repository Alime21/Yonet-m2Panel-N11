class FavoritesInteractor: FavoritesInteractorProtocol {
    weak var output: FavoritesInteractorOutputProtocol?

    func fetchFavorites() {
        let favorites = FavoriteManager.shared.getFavorites()
        output?.didFetchFavorites(favorites)
    }

}
