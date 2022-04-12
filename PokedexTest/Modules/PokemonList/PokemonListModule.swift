//
//  PokemonListModule.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 9/04/22.
//

import UIKit

final class PokemonListModule {
    private var view: PokemonListViewProtocol
    private var router: PokemonListRouterProtocol
    private var interactor: PokemonListInteractorProtocol
    private var presenter: PokemonListPresenterProtocol
        
    init(view: PokemonListViewProtocol = PokemonListView(),
         router: PokemonListRouterProtocol = PokemonListRouter(),
         interactor: PokemonListInteractorProtocol = PokemonListInteractor(),
         presenter: PokemonListPresenterProtocol = PokemonListPresenter()) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.presenter = presenter
    }
}

extension PokemonListModule: AppModule {
    func assemble() -> UIViewController? {
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        view.presenter = presenter
        return view as? UIViewController
    }
}
