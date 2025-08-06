import UIKit

class FavoriteManager {
    static let shared = FavoriteManager()

    private let key = "favorite_users"

    private init() {}

    func getFavorites() -> [GitHubUserItem] {
        if let data = UserDefaults.standard.data(forKey: key),
           let users = try? JSONDecoder().decode([GitHubUserItem].self, from: data) {
            return users
        }
        return []
    }

    func isFavorite(username: String) -> Bool {
        return getFavorites().contains { $0.login == username }
    }

    func addFavorite(user: GitHubUserItem) {
        var favorites = getFavorites()
        if !favorites.contains(where: { $0.login == user.login }) {
            favorites.append(user)
            save(favorites)
        }
    }

    func removeFavorite(username: String) {
        var favorites = getFavorites()
        favorites.removeAll(where: { $0.login == username })
        save(favorites)
    }

    private func save(_ favorites: [GitHubUserItem]) {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

