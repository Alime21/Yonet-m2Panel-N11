//API den gelen cevabı modeller
struct GitHubSearchResponse: Codable {
    let items: [GitHubUserItem]    ///JSON daki items dizisi GitHubUserItem nesnelerini içerir
}
