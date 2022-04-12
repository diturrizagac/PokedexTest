//
//  PokemonListInteractor.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 9/04/22.
//

import UIKit

class PokemonListInteractor: PokemonListInteractable {
    
    weak var presenter: PokemonListPresenterProtocol?
    
    var modelDictionary: [Int:PokemonViewCellModel]
    var pokemonDictionary: [Int:PokemonListResponse]
    private let quantity: Int
    
    init(modelDictionary: [Int:PokemonViewCellModel] = [:],
         pokemonDictionary: [Int:PokemonListResponse] = [:],
         quantity: Int = 151) {
        self.modelDictionary = modelDictionary
        self.pokemonDictionary = pokemonDictionary
        self.quantity = quantity
    }
    
    private func setupPokemon(pokemon: PokemonListResponse, index: Int) {
        let model = PokemonViewCellModel(titleText: pokemon.name,
                                         type: pokemon.types.first?.type.name ?? "",
                                         image: nil)
        modelDictionary[index-1] = model
        pokemonDictionary[index-1] = pokemon
    }
}

extension PokemonListInteractor: PokemonListInteractorServiceHander {
    func loadPokemons() {
        let dispatchGroup = DispatchGroup()
        for id in 1...quantity {
            dispatchGroup.enter()
            CallPokemonList(path: id).execute(
                onSuccess: { [weak self] pokemon in
                    guard let weakSelf = self else { return }
                    weakSelf.setupPokemon(pokemon: pokemon, index: id)
                    dispatchGroup.enter()
                    let imageUrl = self?.pokemonDictionary[id-1]?.sprites.front_default
                    
                    CallPokemonImage(url: imageUrl ?? "").execute(completion: { [weak self] responseImage in
                        self?.modelDictionary[id-1]?.updateImage(image: responseImage)
                        dispatchGroup.leave()
                    })
                    dispatchGroup.leave()
                },
                onError: { [weak self] error in
                    guard let weakSelf = self else { return }
                    weakSelf.presenter?.fetchServiceFailure(message: error)
                    dispatchGroup.leave()
                })
        }
        
        dispatchGroup.notify(queue: .main, execute: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.presenter?.fetchServiceSuccess()
        })
    }
}
