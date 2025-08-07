//kullanıcı modelini temsil edr
struct GitHubUserItem: Codable, Equatable {
    let login: String         /// kullanıcı adı
    let avatar_url: String    /// kullanıcı resmi
    var isFavorite: Bool = false
    
    init(login: String, avatar_url: String, isFavorite: Bool = false) {
            self.login = login
            self.avatar_url = avatar_url
            self.isFavorite = isFavorite
        }
    
    enum CodingKeys: String, CodingKey {
            case login
            case avatar_url
            case isFavorite
        }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            login = try container.decode(String.self, forKey: .login)
            avatar_url = try container.decode(String.self, forKey: .avatar_url)
            isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(login, forKey: .login)
            try container.encode(avatar_url, forKey: .avatar_url)
            try container.encode(isFavorite, forKey: .isFavorite)
        }
}
