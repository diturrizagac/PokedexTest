//
//  PokemonViewCell.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 9/04/22.
//

import UIKit

class PokemonViewCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var mainImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // MARK: - Constriants
    private var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: [
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
        constraints.append(contentsOf: [
            mainImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            mainImageView.widthAnchor.constraint(equalToConstant: 75),
            mainImageView.heightAnchor.constraint(equalToConstant: 75),
            mainImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        constraints.append(contentsOf: [
            footerLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor),
            footerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            footerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            footerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
        return constraints
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(titleLabel)
        addSubview(mainImageView)
        addSubview(footerLabel)
    }
    
    func setupView() {
        backgroundColor = .white
        dropShadowEffect()
        NSLayoutConstraint.activate(staticConstraints)
    }
    
    func fillView(model: PokemonViewCellModel) {
        titleLabel.text = model.titleText
        mainImageView.image = model.image
        footerLabel.text = model.type
        backgroundColor = getBackground(type: model.type)
    }
}

extension PokemonViewCell {
    func getBackground(type: String) -> UIColor {
        switch type {
        case "fire": return .systemRed
        case "poison": return .systemGreen
        case "water": return .systemBlue
        case "electric": return .systemYellow
        case "physic": return .systemPurple
        case "normal": return .systemOrange
        case "ground": return .systemGray
        case "flying": return .systemTeal
        case "bug": return .systemTeal
        case "fairy": return .systemPink
        case "grass": return .systemGreen
        default: return .systemIndigo
        }
    }
}
