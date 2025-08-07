import UIKit
//Favori ekle/sil/kontrol işlerini yap
class FavoriteManager {
    static let shared = FavoriteManager()  ///Singleton olarak tanımlandı: FavoriteManager.shared şeklinde her yerden erişilebilir (global); bu sayede fav'lar her zamna aynı listede saklanır; bellekte fazldan örnek oluşturulmaz
    private let key = "favorite_users"     ///fav kullanıcıları saklamak için UserDefaults'ta kullanılcak key
    private init() {}    ///başka bir yerden FavoriteManager() oluşturulmasını engeller, sadece shared kullanılır
    
    ///UserDefaults'tan daha önce kaydedilen fav kullanıcıları alır;JSON olaeak saklandığı için decode edilir; değilse boş dizi return et
    ///UserDefaults.standard otomatik tanımlı singleton nesne  .set() .data() gibi metotlarla veri saklar ve okuruz
    func getFavorites() -> [GitHubUserItem] {
        if let data = UserDefaults.standard.data(forKey: key),
           let users = try? JSONDecoder().decode([GitHubUserItem].self, from: data) {
            return users
        }
        return []
    }
    
    ///Kullanıcının fav'a eklenip eklenmediğini kontrol eder;getFavorites()ile alınan kullanıcılar içinde login (yani githubkullanıcı adı) eşleşmesi arar
    func isFavorite(username: String) -> Bool {
        return getFavorites().contains { $0.login == username }
    }
    
    /// yeni kullanıcıyı favlara ekle sonra save() ile UserDefaults'a kaydet
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

    /// verilen kullanıcı listesini JSON'a çevirir ve UserDefaults'a kaydeder
    private func save(_ favorites: [GitHubUserItem]) {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

