//
//  AppModule.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 9/04/22.
//

import UIKit

protocol AppModule {
    func assemble() -> UIViewController?
}

protocol ModuleFactoryProtocol {
    func makePokemonList(with navigationController: UINavigationController) -> PokemonListModule
    func makePokemDetail(with navigationController: UINavigationController) -> PokemonDetailModule
}

struct ModuleFactory: ModuleFactoryProtocol {
    func makePokemonList(with navigationController: UINavigationController) -> PokemonListModule {
        let router = PokemonListRouter(navigationController: navigationController, moduleFactory: self)
        return PokemonListModule(router: router)
    }
    
    func makePokemDetail(with navigationController: UINavigationController) -> PokemonDetailModule {
        return PokemonDetailModule()
    }
}
