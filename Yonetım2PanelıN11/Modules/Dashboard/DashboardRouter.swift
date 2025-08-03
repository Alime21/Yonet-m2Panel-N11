//go to another screen
import UIKit

protocol DashboardRouterProtocol {
    func navigateToSearch(from view: UIViewController)
    
}

class DashboardRouter: DashboardRouterProtocol {
    //DashboardViewController'a bastığında search ekranına geçer:
    //presenterdan yönlendirilen fonksiyon router da search ekranını VIPER olarak oluşturyor ve pushluyor
    func navigateToSearch(from view: UIViewController) {
        print("dashboard router navigatetosearch çağrıldı")
        let searchVC = SearchModuleBuilder.build()
        print("Oluşturulan SearchVC -> \(searchVC)")
        view.navigationController?.pushViewController(searchVC, animated: true)
    }
}

