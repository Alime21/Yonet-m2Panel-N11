import UIKit

/// Favorileme için kullanılan UserDefaults çözümlü favori yönetim sınıfı
class FavoriteManager {
    static let shared = FavoriteManager()

    private let key = "favorite_users"

    private init() {}

    func getFavorites() -> Set<String> {
        let saved = UserDefaults.standard.array(forKey: key) as? [String] ?? []
        return Set(saved)
    }
    
    func isFavorite(username: String) -> Bool {
        return getFavorites().contains(username)
    }

    func addFavorite(username: String) {
        var favorites = getFavorites()
        favorites.insert(username)
        UserDefaults.standard.set(Array(favorites), forKey: key)
    
    }

    func removeFavorite(username: String) {
        var favorites = getFavorites()
        favorites.remove(username)
        UserDefaults.standard.set(Array(favorites), forKey: key)
    }

    
}
