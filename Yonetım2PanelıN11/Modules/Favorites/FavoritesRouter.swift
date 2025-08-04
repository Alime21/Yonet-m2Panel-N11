
import UIKit

protocol FavoritesRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

class FavoritesRouter: FavoritesRouterProtocol {
    /* weak var viewController: UIViewController? */
    
    static func createModule() -> UIViewController {
            return FavoritesModuleBuilder.build()
        }
}
