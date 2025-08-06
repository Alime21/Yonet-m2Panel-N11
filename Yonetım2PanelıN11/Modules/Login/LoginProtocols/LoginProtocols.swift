import UIKit

/// ViewController Protocol
protocol ViewProtocol: AnyObject {
    func showError(message: String)
    func openSafariAuth(url: URL)
}

/// PRESENTER Protocol
protocol PresenterProtocol: AnyObject {
    var view: ViewProtocol? { get set }
    var interactor: InteractorProtocol? { get set }
    var router: RouterProtocol? { get set }
    
    func loginButtonTapped()
    func handleGitHubCallback(code: String)
}

///ROUTER Protocol
protocol RouterProtocol {
    func navigateToDashboard(from view: UIViewController)
}
