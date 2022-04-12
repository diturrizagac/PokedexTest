//
//  PokemonDetailProtocols.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 11/04/22.
//

import UIKit

// MARK: Router
typealias PokemonDetailRouterProtocol = PokemonDetailRoutable & PokemonDetailRouterNavigable

protocol PokemonDetailRoutable: AnyObject {
    var navigationController: UINavigationController { get set }
}

protocol PokemonDetailRouterNavigable: AnyObject {
    func showPokemonDetail()
}

// MARK: View
typealias PokemonDetailViewProtocol = PokemonDetailViewable & PokemonDetailViewConfigurable & PokemonDetailViewUpdatable

protocol PokemonDetailViewable: AnyObject {
    var presenter: PokemonDetailPresenterProtocol? { get set }
}

protocol PokemonDetailViewConfigurable: AnyObject {
    func addViews()
    func setupViews()
    func setupConstraints()
    func configureTitle(title: String)
}

protocol PokemonDetailViewUpdatable: AnyObject {
    func showError()
}

// MARK: Presenter
typealias PokemonDetailPresenterProtocol = PokemonDetailPresentable & PokemonDetailPresenterViewConfiguration & PokemonDetailDataSource & PokemonDetailPresenterServiceInteractable & PokemonDetailPresenterServiceHandler & PokemonDetailPresenterActionable

protocol PokemonDetailPresentable: AnyObject {
    var view: PokemonDetailViewProtocol? { get set }
    var interactor: PokemonDetailInteractorProtocol { get set }
    var router: PokemonDetailRouterProtocol { get set }
}

protocol PokemonDetailPresenterViewConfiguration: AnyObject {
    func loadView()
    func viewDidLoad()
}

protocol PokemonDetailDataSource: AnyObject {
    var numberOfRows: Int { get }
    func cellModel(at index: Int) -> PokemonViewCellModel?
}

protocol PokemonDetailPresenterServiceInteractable: AnyObject {
    func fetchPokemons()
}

protocol PokemonDetailPresenterServiceHandler: AnyObject {
    func fetchServiceSuccess()
    func fetchServiceFailure(message: String)
}

protocol PokemonDetailPresenterActionable: AnyObject {
    func didSelectCell(at index: Int)
}


// MARK: - Interactor
typealias PokemonDetailInteractorProtocol = PokemonDetailInteractable & PokemonDetailInteractorServiceHander

protocol PokemonDetailInteractable: AnyObject {
    var presenter: PokemonDetailPresenterProtocol? { get set }
}

protocol PokemonDetailInteractorServiceHander: AnyObject {
    func loadPokemons()
}
