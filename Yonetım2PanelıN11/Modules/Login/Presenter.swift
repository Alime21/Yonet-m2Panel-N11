//2.
//interactor.login(email:) metodunu çağırır
//giriş başarılı ise router.navigateToDashboard() çağrılır
//giriş başarısız ise view.showError() çağrılır

import UIKit
//Presenter'ın View,Interactor ve Roıuter ile nasıl iletişim kurduğunu:
protocol PresenterProtocol: AnyObject {
    var view: ViewProtocol? { get set }
    var interactor: InteractorProtocol? { get set }
    var router: RouterProtocol? { get set }
    
    func loginButtonTapped()
    func handleGitHubCallback(code: String)
}
//hem View'dan gelen tetikleyici hem de Interactor'den gelen sonucu işleyen sınıf
class Presenter: PresenterProtocol, InteractorOutputProtocol {
      //VIPER bağımlılıkları
      weak var view: ViewProtocol?
      var interactor: InteractorProtocol?
      var router: RouterProtocol?
      
      private let clientID = "Ov23liNGUQCWIoZtxjGj"
      private let clientSecret = "5140f3def41cfc5be99377e126e0ca9d693f55a3"
      private let redirectURI = "myapp://oauth-callback"
        
    
    func loginButtonTapped() {
        let scope = "user"
        
        let authURLString = "https://github.com/login/oauth/authorize?client_id=\(clientID)&scope=\(scope)&redirect_uri=\(redirectURI)"
        
        guard let url = URL(string: authURLString) else {
            view?.showError(message: "URL oluşturulamadı")
            return
        }
        view?.openSafariAuth(url: url)
    }
    
     func handleGitHubCallback(code: String) {
           interactor?.exchangeCodeForToken(code: code, clientID: clientID, clientSecret: clientSecret, redirectURI: redirectURI)
       }
    
    //başarılı ise Dashboard; değilse View uyarılır
      func loginSucceeded() {
          print("login başarılı")
          if let viewController = view as? UIViewController {
              router?.navigateToDashboard(from: viewController)
          }
      }
    
      func loginFailed(error: String) {
          view?.showError(message: error)
      }
}

