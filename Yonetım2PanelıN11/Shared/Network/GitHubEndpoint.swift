//API URL lerini üretir
enum GitHubEndpoint {
    case searchUsers(query: String, page: Int, perPage: Int)
    
    var url: String {
        switch self {
        case .searchUsers(let query, let page, let perPage):
            let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
                        return "https://api.github.com/search/users?q=\(encodedQuery)&page=\(page)&per_page=\(perPage)"
        }
    }
}


