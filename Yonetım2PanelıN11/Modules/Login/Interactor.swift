//giriş işlemini yapar(örnek sabit email kontrolü)
//sonuç başarılı ise presenter.loginSucceeded() çağrılır
//hatalıysa presenter.loginFailed() çağrılır
import Foundation
//Presenter'ın Interactor ile iletişimi (POP)
protocol InteractorProtocol {
    func login(email: String)
}
//Interactor'dan Presenter'a geri dönüş için
protocol InteractorOutputProtocol: AnyObject {
    func loginSucceeded()
    func loginFailed(error: String)
}
//Interactor işlemleri yapar ve sonucu Presenter'a bildirir
//weak olması retain cycle'ı önler
class Interactor: InteractorProtocol {
    weak var presenter: InteractorOutputProtocol?
    
    //login kontrolü
    func login(email: String) {
        if email == "test@example.com" {
                    presenter?.loginSucceeded()
                } else {
                    presenter?.loginFailed(error: "Geçersiz e-posta ya da şifre")
                }
    }
}

