//
//  ApplicationLoader.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 9/04/22.
//

import UIKit

struct ApplicationLoader {
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let moduleFactory: ModuleFactoryProtocol
    
    init(window: UIWindow = UIWindow(frame: UIScreen.main.bounds),
         navigationController: UINavigationController = UINavigationController(),
         moduleFactory: ModuleFactoryProtocol = ModuleFactory()) {
        self.window = window
        self.navigationController = navigationController
        self.moduleFactory = moduleFactory
    }
    
    func build() {
        let module = moduleFactory.makePokemonList(with: navigationController)
        let viewController = module.assemble()
        setRootViewController(viewController)
    }
    
    private func setRootViewController(_ viewController: UIViewController?) {
        window.rootViewController = navigationController
        if let viewController = viewController {
            navigationController.pushViewController(viewController, animated: true)
        }
        window.makeKeyAndVisible()
    }
}
