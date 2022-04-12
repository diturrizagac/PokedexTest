//
//  PokemonListRouter.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 9/04/22.
//

import UIKit

final class PokemonListRouter: PokemonListRoutable {
    var navigationController: UINavigationController
    private let moduleFactory: ModuleFactoryProtocol
    
    init(navigationController: UINavigationController = UINavigationController(),
         moduleFactory: ModuleFactoryProtocol = ModuleFactory()) {
        self.navigationController = navigationController
        self.moduleFactory = moduleFactory
    }
}

extension PokemonListRouter: PokemonListRouterNavigable {
    func showPokemonDetail() {
        
    }
}
