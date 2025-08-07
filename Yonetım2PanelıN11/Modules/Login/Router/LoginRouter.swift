///giriş başarılıysa Dashboard'a yönlendir
import UIKit
class Router: RouterProtocol {
    /// push işlemi: dashboarda yönlendirir
    func navigateToDashboard(from view: UIViewController) {
        let dashboardVC = DashboardModuleBuilder.build()
        view.navigationController?.pushViewController(dashboardVC, animated: true)
    }
}
