// giriş başarılıysa Dashboard'a yönlendir
import UIKit
protocol RouterProtocol {
    func navigateToDashboard(from view: UIViewController)
}
class Router: RouterProtocol {
    //push işlemi: dashboarda yönlendirir
    func navigateToDashboard(from view: UIViewController) {
        let dashboardVC = DashboardViewController()
        view.navigationController?.pushViewController(dashboardVC, animated: true)
    }
}
