import UIKit
// definiton of protocol
protocol PresenterProtocol: AnyObject {
    var view: ViewProtocol? { get set }
    var interactor: InteractorProtocol? { get set }
    var router: RouterProtocol? { get set }
    
    func loginButtonTapped()
    
}

class Presenter: PresenterProtocol, InteractorOutputProtocol {
      weak var view: ViewProtocol?
      var interactor: InteractorProtocol?
      var router: RouterProtocol?

      func loginButtonTapped() {
          print("sadaksndlkadnks")
          interactor?.login(email: "test@example.com")
      }

      func loginSucceeded() {
          print("login başarılı")
          if let viewController = view as? UIViewController {
              router?.navigateToDashboard(from: viewController)
          }
      }

      func loginFailed(error: String) {
          print("Login hatalı: \(error)")
      }
}

