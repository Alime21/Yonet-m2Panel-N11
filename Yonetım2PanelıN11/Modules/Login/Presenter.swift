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
}
//hem View'dan gelen tetikleyici hem de Interactor'den gelen sonucu işleyen sınıf
class Presenter: PresenterProtocol, InteractorOutputProtocol {
      //VIPER bağımlılıkları
      weak var view: ViewProtocol?
      var interactor: InteractorProtocol?
      var router: RouterProtocol?
      
    //!!!!!kullanıcıdan gelen email bilgisi şimdilik sabit; sonra view'dan email parametresi alıcam -> (email: email) ve viewcontroller içine presenter?.loginButtonTapped(email: email) bunu yazcam
      func loginButtonTapped() {
          interactor?.login(email: "test@example.com")
      }
    //başarılı ise Dashboard; değilse View uyarılır
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

