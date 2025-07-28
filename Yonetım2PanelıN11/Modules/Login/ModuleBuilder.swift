// modülün tüm bağımlılıklarını kurar 
import UIKit
class ModuleBuilder {
    //storyboardan LoginViewController'ı alıyor
    static func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        //bileşenleri oluşturdum
        let presenter = Presenter()
        let interactor = Interactor()
        let router = Router()
        //bağlantıları kurdum
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        view.presenter = presenter
        //login modülünü geri döndürür
        return view
        
    }
}

