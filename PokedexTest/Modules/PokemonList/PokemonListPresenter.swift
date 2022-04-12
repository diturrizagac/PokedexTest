//
//  PokemonListPresenter.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 9/04/22.
//

import UIKit

final class PokemonListPresenter: PokemonListPresentable {
    weak var view: PokemonListViewProtocol?
    var interactor: PokemonListInteractorProtocol
    var router: PokemonListRouterProtocol
    
    init(view: PokemonListViewProtocol? = nil ,
         interactor: PokemonListInteractorProtocol = PokemonListInteractor(),
         router: PokemonListRouterProtocol = PokemonListRouter()) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension PokemonListPresenter: PokemonListPresenterViewConfiguration {
    func loadView() {
        view?.addViews()
    }
    
    func viewDidLoad() {
        view?.setupViews()
        view?.setupConstraints()
        view?.configureTitle(title: "Pokedex")
        fetchPokemons()
    }
}

extension PokemonListPresenter: PokemonListDataSource {
    var numberOfRows: Int {
        return interactor.modelDictionary.count
    }
    
    func cellModel(at index: Int) -> PokemonViewCellModel? {
        return interactor.modelDictionary[index]
    }
}

extension PokemonListPresenter: PokemonListPresenterServiceInteractable {
    func fetchPokemons() {
        interactor.loadPokemons()
    }
}

extension PokemonListPresenter: PokemonListPresenterServiceHandler {
    func fetchServiceSuccess() {
        view?.reloadData()
    }
    
    func fetchServiceFailure(message: String) {
        view?.showError()
    }
}

extension PokemonListPresenter: PokemonListPresenterActionable {
    func didSelectCell(at index: Int) {
        router.showPokemonDetail()
    }
}
