import Foundation

protocol SearchInteractorProtocol {
    func search(query: String)
    func fetchAllUsers()
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func didFetchAllUsers(_ users: [GitHubUserItem])
    func didFetchResults(_ results: [GitHubUserItem])
    func didFail(_ errorMessage: String)
}

class SearchInteractor: SearchInteractorProtocol {
    
    weak var presenter: SearchInteractorOutputProtocol?
    private var allUsers: [GitHubUserItem] = []
    
    func search(query: String) {
        NetworkManager.shared.request(endpoint: .searchUsers(query: query, page: 1, perPage: 20)
        ) { (result: Result<GitHubSearchResponse, Error>) in
            switch result {
            case .success(let response):
                self.presenter?.didFetchResults(response.items)
            case .failure(let error):
                self.presenter?.didFail(error.localizedDescription)
            }
        }
    }
    
    func fetchAllUsers() {
        NetworkManager.shared.request(
            endpoint: .searchUsers(query: "swift", page: 1, perPage: 10)
        ) { (result: Result<GitHubSearchResponse, Error>) in
            switch result {
            case .success(let response):
                self.allUsers = response.items
                self.presenter?.didFetchResults(response.items)
            case .failure(let error):
                self.presenter?.didFail(error.localizedDescription)
            }
        }
    }
}

