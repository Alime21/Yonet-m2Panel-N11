// 1.
// kullanıcıdan email inputunu al
//butona basınca presenter.loginButtonTapped() çağrılır
import UIKit
import SafariServices
class LoginViewController: UIViewController, ViewProtocol {
    //presenter referansı(VIPER/MVP iletişimi temel noktası)
    var presenter: PresenterProtocol!
    @IBOutlet weak var emailBtn: UITextField!
    
    //controller yüklendiğinde çalışır; şu an boş
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //butona basınca çalışır.Presenter'a login işlemini başlatmasını söyledi (protocol oriented programming)
    @IBAction func deneme(_ sender: Any) {
        presenter?.loginButtonTapped()
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
                present(alert, animated: true)
    }
    
    func openSafariAuth(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    /// AppDelegate veya SceneDelegate'den çağrılmalı
    func handleGitHubCallback(code: String) {
        presenter.handleGitHubCallback(code: code)
    }
}
