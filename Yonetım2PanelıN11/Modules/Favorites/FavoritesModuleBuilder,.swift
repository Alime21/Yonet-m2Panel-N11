//
//  FavoriModuleBuilder,.swift
//  Yonetım2PanelıN11
//
//  Created by alime.kilinc on 30.07.2025.
//

import UIKit

class FavoritesModuleBuilder {
    static func build() -> UIViewController {
        let view = FavoritesViewController()
        let presenter = FavoritesPresenter()
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter

        return view
    }
}
