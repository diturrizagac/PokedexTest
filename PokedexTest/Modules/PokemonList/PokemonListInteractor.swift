//
//  PokemonListInteractor.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 9/04/22.
//

import UIKit

class PokemonListInteractor: PokemonListInteractable {
    
    weak var presenter: PokemonListPresenterProtocol?
    
    var pokemonList: [PokemonModel]
    var cachePokemonList: [PokemonModel]
    
    private let quantity: Int
    
    init(pokemonList: [PokemonModel] = [],
         quantity: Int = 151) {
        self.pokemonList = pokemonList
        self.cachePokemonList = pokemonList
        self.quantity = quantity
    }
    
    private func appendPokemon(pokemon: PokemonListResponse, pokemonImage: UIImage?){
        let pokemonModel = PokemonModel(response: pokemon, pokemonImage: pokemonImage)
        pokemonList.append(pokemonModel)
    }
    
    private func sortList() {
        pokemonList.sort {
            $0.id < $1.id
        }
        cachePokemonList = pokemonList
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
                    dispatchGroup.enter()
                    let imageUrl = pokemon.sprites.front_default
                    CallPokemonImage(url: imageUrl).execute(completion: { responseImage in
                        weakSelf.appendPokemon(pokemon: pokemon, pokemonImage: responseImage)
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
            weakSelf.sortList()
            weakSelf.presenter?.fetchServiceSuccess()
        })
    }
}
