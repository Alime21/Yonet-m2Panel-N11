import UIKit
import Foundation

///VİEWCONTROLLER Protocol
protocol SearchViewProtocol: AnyObject {
    func showInitialUsers(_ users: [GitHubUserItem])
    func showResults(_ results: [GitHubUserItem])
    func showError(_ message: String)
}

///PRESENTER Protocol
protocol SearchPresenterProtocol: AnyObject {
    func performSearch(with query: String)
    func viewDidLoad()
}

///INTERACTOR Protocols
protocol SearchInteractorProtocol {
    func search(query: String)
    func fetchAllUsers()
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func didFetchAllUsers(_ users: [GitHubUserItem])
    func didFetchResults(_ results: [GitHubUserItem])
    func didFail(_ error: String)
}

///ROUTER Protocol
protocol SearchRouterProtocol {
    func navigateToSearch(from view: UIViewController)
}

