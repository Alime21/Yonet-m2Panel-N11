import Foundation

class SearchInteractor: SearchInteractorProtocol {
    
    weak var presenter: SearchInteractorOutputProtocol?
    
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
                self.presenter?.didFetchAllUsers(response.items)
            case .failure(let error):
                self.presenter?.didFail(error.localizedDescription)
            }
        }
    }
}

