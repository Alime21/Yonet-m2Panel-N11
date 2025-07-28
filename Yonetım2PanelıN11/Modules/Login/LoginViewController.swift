// 1.
// kullanıcıdan email inputunu al
//butona basınca presenter.loginButtonTapped() çağrılır

import UIKit

protocol ViewProtocol: AnyObject {
    func showError(message: String)
}
class LoginViewController: UIViewController, ViewProtocol {
    //presenter referansı(VIPER/MVP iletişimi temel noktası)
    var presenter: Presenter!
    @IBOutlet weak var emailBtn: UITextField!
    
    //controller yüklendiğinde çalışır; şu an boş
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //butona basınca çalışır.Presenter'a login işlemini başlatmasını söyledi (protocol oriented programming)
    @IBAction func deneme(_ sender: Any) {
        print("presenter is \(String(describing: presenter))")
        let email = emailBtn.text ?? ""
        presenter?.loginButtonTapped()
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
                present(alert, animated: true)
    }
    
}
