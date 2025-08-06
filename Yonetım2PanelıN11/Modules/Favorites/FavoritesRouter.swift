import UIKit

class FavoritesRouter: FavoritesRouterProtocol {
    static func createModule() -> UIViewController {
            return FavoritesModuleBuilder.build()
        }
}
