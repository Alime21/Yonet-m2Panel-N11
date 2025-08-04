struct GitHubUserItem: Codable {
    let login: String
    let avatar_url: String
    var isFavorite: Bool? = false
}
