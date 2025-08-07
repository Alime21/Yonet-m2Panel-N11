import UIKit

class SearchRouter: SearchRouterProtocol {
    func navigateToSearch(from view: UIViewController) {
        let searchVC = SearchModuleBuilder.build()
        view.navigationController?.pushViewController(searchVC, animated: true)
    }
}
