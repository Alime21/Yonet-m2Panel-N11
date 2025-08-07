//giriş işlemini yapar(örnek sabit email kontrolü)
//sonuç başarılı ise presenter.loginSucceeded() çağrılır
//hatalıysa presenter.loginFailed() çağrılır
import Foundation
//Presenter'ın Interactor ile iletişimi (POP)
protocol InteractorProtocol {
    func exchangeCodeForToken(code: String, clientID: String, clientSecret: String, redirectURI: String)
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
    func exchangeCodeForToken(code: String, clientID: String, clientSecret: String, redirectURI: String) {
           let tokenURL = URL(string: "https://github.com/login/oauth/access_token")!
           var request = URLRequest(url: tokenURL)
           request.httpMethod = "POST"
           let params = "client_id=\(clientID)&client_secret=\(clientSecret)&code=\(code)&redirect_uri=\(redirectURI)"
           request.httpBody = params.data(using: .utf8)
           request.addValue("application/json", forHTTPHeaderField: "Accept")
           
           URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
               guard let self = self else { return }
               
               if let error = error {
                   DispatchQueue.main.async {
                       self.presenter?.loginFailed(error: "Token alınamadı: \(error.localizedDescription)")
                   }
                   return
               }
               
               guard let data = data,
                     let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                     let accessToken = json["access_token"] as? String else {
                   DispatchQueue.main.async {
                       self.presenter?.loginFailed(error: "Access token alınamadı.")
                   }
                   return
               }
               
               print(accessToken, "AccessToken")
               UserDefaults.standard.set(accessToken, forKey: "UserToken")
               
               DispatchQueue.main.async {
                   self.presenter?.loginSucceeded()
               }
           }.resume()
       }
}

