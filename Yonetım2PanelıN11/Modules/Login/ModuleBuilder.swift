// login links
import UIKit
class ModuleBuilder {
    static func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let presenter = Presenter()
        let interactor = Interactor()
        let router = Router()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        view.presenter = presenter
        
        return view
        
    }
}

