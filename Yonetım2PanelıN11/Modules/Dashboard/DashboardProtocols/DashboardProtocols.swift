import UIKit
import Foundation

///PRESENTER Protoocl
protocol DashboardPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapKayıttakiler()
    func didTapFavorites()
}

///INTERACTOR Protocol
protocol DashboardInteractorProtocol {}

///ROUTER Protocol
protocol DashboardRouterProtocol {
    func navigateToSearch(from view: UIViewController)
}
