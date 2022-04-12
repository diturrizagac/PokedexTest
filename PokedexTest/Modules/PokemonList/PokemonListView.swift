//
//  PokemonListView.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 9/04/22.
//

import UIKit

class PokemonListView: UIViewController, PokemonListViewable {
    // MARK: - Properties
    var presenter: PokemonListPresenterProtocol?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PokemonViewCell.self, forCellWithReuseIdentifier: "PokemonViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Constriants
    private var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        return constraints
    }
    
    // MARK: - Lifecycle Methods
    override func loadView() {
        super.loadView()
        presenter?.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

// MARK: - Configuration
extension PokemonListView: PokemonListViewConfigurable {
    func addViews() {
        view.addSubview(collectionView)
    }
    
    func setupViews() {
        view.backgroundColor = .white
        navigationItem.titleView?.tintColor = .black
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate(staticConstraints)
    }
    
    func configureTitle(title: String) {
        navigationItem.title = title
    }
}

// MARK: - Reload
extension PokemonListView: PokemonListViewReloadable {
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Update
extension PokemonListView: PokemonListViewUpdatable {
    func showError() {
        print("error")
    }
}

// MARK: - Delegates
extension PokemonListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let rows = presenter?.numberOfRows else { return 0 }
        return rows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = presenter?.cellModel(at: indexPath.row),
              let cell: PokemonViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonViewCell",
                                                                             for: indexPath) as? PokemonViewCell else {
                  return UICollectionViewCell()
              }
        cell.fillView(model: model)
        return cell
    }
}

extension PokemonListView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectCell(at: indexPath.row)
    }
}

extension PokemonListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 36)/2
        return CGSize(width: width, height: width/1.5)
    }
}
