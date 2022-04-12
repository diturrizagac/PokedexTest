//
//  PokemonViewCellModel.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 11/04/22.
//

import UIKit

struct PokemonViewCellModel: Hashable {
    let titleText: String
    let type: String
    var image: UIImage?
    
    mutating func updateImage(image: UIImage?) {
        self.image = image
    }
}
