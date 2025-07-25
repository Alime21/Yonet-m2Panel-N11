//The structure that connects the module. It creates and connects all VIPER components.
import UIKit

class DashboardModuleBuilder {
    static func build() -> UIViewController {
        let view = DashboardViewController()
        let presenter = DashboardPresenter()
        let interactor = DashboardInteractor()
        let router = DashboardRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }
}


