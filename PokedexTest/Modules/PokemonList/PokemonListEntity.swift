//
//  PokemonListEntity.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 9/04/22.
//

import UIKit

struct CallPokemonList: ResponseDispatcher {
    typealias ResponseType = PokemonListResponse
    var path: String
    var request: RequestTypeProtocol {
        return RequestType(urlString: "https://pokeapi.co/api/v2/pokemon",
                           path: "/\(path)",
                           query: nil)
    }
    
    init(path: Int) {
        self.path = String(path)
    }
}

struct CallPokemonImage: ResponseDispatcher {
    typealias ResponseType = PokemonListResponse
    var url: String
    var request: RequestTypeProtocol {
        return RequestType(urlString: url,
                           path: nil,
                           query: nil)
    }
    
    init(url: String) {
        self.url = url
    }
}

struct PokemonListResponse: Codable, Hashable {
    var name: String
    var types: [Types]
    var sprites: Sprites
}

struct Sprites: Codable, Hashable {
    let front_default: String
}

struct Types: Codable, Hashable {
    let slot: Int
    let type: TypeItself
}

struct TypeItself: Codable, Hashable {
    let name: String
    let url: String
}
