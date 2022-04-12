//
//  PokemonDetailView.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 11/04/22.
//

import UIKit

class PokemonDetailView: UIViewController, PokemonDetailViewable {
    var presenter: PokemonDetailPresenterProtocol?
    

}

extension PokemonDetailView: PokemonDetailViewConfigurable {
    func addViews() {
        
    }
    
    func setupViews() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func configureTitle(title: String) {
        
    }
    
    
}

extension PokemonDetailView: PokemonDetailViewUpdatable {
    func showError() {
        
    }
    
    
}
