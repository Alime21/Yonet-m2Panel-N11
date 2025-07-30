//
//  FavoriRouter.swift
//  Yonetım2PanelıN11
//
//  Created by alime.kilinc on 30.07.2025.
//

import UIKit

protocol FavoritesRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

class FavoritesRouter: FavoritesRouterProtocol {
    static func createModule() -> UIViewController {
        return FavoritesModuleBuilder.build()
    }
}
