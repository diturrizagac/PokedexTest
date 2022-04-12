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
        return interactor.pokemonList.count
    }
    
    func cellModel(at index: Int) -> PokemonViewCellModel? {
        let pokemon = interactor.pokemonList[index]
        let model = PokemonViewCellModel(titleText: pokemon.name,
                                         type: pokemon.type,
                                         image: pokemon.image)
        return model
    }
}

extension PokemonListPresenter: PokemonListPresenterServiceInteractable {
    func fetchPokemons() {
        interactor.loadPokemons()
    }
}

extension PokemonListPresenter: PokemonListPresenterServiceHandler {
    func fetchServiceSuccess() {
        interactor.cachePokemonList = interactor.pokemonList
        view?.reloadData()
    }
    
    func fetchServiceFailure(message: String) {
        view?.showError()
    }
}

extension PokemonListPresenter: PokemonListPresenterActionable {
    func didSearchActive(with text: String) {
        interactor.pokemonList = interactor.cachePokemonList
        guard !text.isEmpty else {
            view?.reloadData()
            return
        }
        let listFiltered = interactor.pokemonList.filter({
            $0.name.contains(text.lowercased())
        })
        
        if !listFiltered.isEmpty {
            interactor.pokemonList = listFiltered
            view?.reloadData()
        }
    }
    
    func didSelectCell(at index: Int) {
        router.showPokemonDetail()
    }
}
