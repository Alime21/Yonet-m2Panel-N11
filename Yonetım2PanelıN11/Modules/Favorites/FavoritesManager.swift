/*class FavoritesManager {
    static let shared = FavoritesManager()
    private init() {}

    private var favorites: [GitHubUserItem] = []

    func add(_ user: GitHubUserItem) {
        if !favorites.contains(where: { $0.login == user.login }) {
            favorites.append(user)
        }
    }

    func remove(_ user: GitHubUserItem) {
        favorites.removeAll { $0.login == user.login }
    }

    func getFavorites() -> [GitHubUserItem] {
        return favorites
    }
}
*/
