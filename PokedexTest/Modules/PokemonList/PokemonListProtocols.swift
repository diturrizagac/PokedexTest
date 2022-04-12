//
//  PokemonListProtocols.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 9/04/22.
//

import UIKit


// MARK: Router
typealias PokemonListRouterProtocol = PokemonListRoutable & PokemonListRouterNavigable

protocol PokemonListRoutable: AnyObject {
    var navigationController: UINavigationController { get set }
}

protocol PokemonListRouterNavigable: AnyObject {
    func showPokemonDetail()
}

// MARK: View
typealias PokemonListViewProtocol = PokemonListViewable & PokemonListViewConfigurable & PokemonListViewReloadable & PokemonListViewUpdatable

protocol PokemonListViewable: AnyObject {
    var presenter: PokemonListPresenterProtocol? { get set }
}

protocol PokemonListViewConfigurable: AnyObject {
    func addViews()
    func setupViews()
    func setupConstraints()
    func configureTitle(title: String)
}

protocol PokemonListViewReloadable: AnyObject {
    func reloadData()
}

protocol PokemonListViewUpdatable: AnyObject {
    func showError()
}

// MARK: Presenter
typealias PokemonListPresenterProtocol = PokemonListPresentable & PokemonListPresenterViewConfiguration & PokemonListDataSource & PokemonListPresenterServiceInteractable & PokemonListPresenterServiceHandler & PokemonListPresenterActionable

protocol PokemonListPresentable: AnyObject {
    var view: PokemonListViewProtocol? { get set }
    var interactor: PokemonListInteractorProtocol { get set }
    var router: PokemonListRouterProtocol { get set }
}

protocol PokemonListPresenterViewConfiguration: AnyObject {
    func loadView()
    func viewDidLoad()
}

protocol PokemonListDataSource: AnyObject {
    var numberOfRows: Int { get }
    func cellModel(at index: Int) -> PokemonViewCellModel?
}

protocol PokemonListPresenterServiceInteractable: AnyObject {
    func fetchPokemons()
}

protocol PokemonListPresenterServiceHandler: AnyObject {
    func fetchServiceSuccess()
    func fetchServiceFailure(message: String)
}

protocol PokemonListPresenterActionable: AnyObject {
    func didSelectCell(at index: Int)
}


// MARK: - Interactor
typealias PokemonListInteractorProtocol = PokemonListInteractable & PokemonListInteractorServiceHander

protocol PokemonListInteractable: AnyObject {
    var presenter: PokemonListPresenterProtocol? { get set }
    
    var modelDictionary: [Int:PokemonViewCellModel] { get set }
    var pokemonDictionary: [Int:PokemonListResponse] { get set }
}

protocol PokemonListInteractorServiceHander: AnyObject {
    func loadPokemons()
}
