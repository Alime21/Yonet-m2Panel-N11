struct GitHubUserItem: Codable {
    let login: String
    let avatar_url: String
    var isFavorite: Bool {
        return FavoriteManager.shared.isFavorite(username: login)
    }
}
