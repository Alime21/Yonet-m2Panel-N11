//verify user input
//make a network call
//notify the presenter of the result
import Foundation
protocol InteractorProtocol {
    func login(email: String)
}
protocol InteractorOutputProtocol: AnyObject {
    func loginSucceeded()
    func loginFailed(error: String)
}
                                        
class Interactor: InteractorProtocol {
    weak var presenter: InteractorOutputProtocol?
    
    func login(email: String) {
        if email == "test@example.com" {
                    presenter?.loginSucceeded()
                } else {
                    presenter?.loginFailed(error: "Geçersiz e-posta ya da şifre")
                }
    }
}

