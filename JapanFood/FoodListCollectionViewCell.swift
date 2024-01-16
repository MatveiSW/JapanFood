//
//  FoodListCollectionViewCell.swift
//  JapanFood
//
//  Created by Матвей Авдеев on 17.01.2024.
//

import UIKit

class FoodListCollectionViewCell: UICollectionViewCell {
    
    let networkManager = NetworkManager.shared
    
    private lazy var foodImageView: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    lazy var foodNameLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.4
        
        return label
    }()
    
    lazy var foodDescriptionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.4
        label.numberOfLines = 3
        
        return label
    }()
    
    lazy var foodPriceLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .white
        
        return label
    }()
    
    lazy var foodWeightLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .lightGray
        
        return label
    }()
    
    lazy var foodPriceAndWeightStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.addArrangedSubview(foodPriceLabel)
        stack.addArrangedSubview(foodWeightLabel)
        
        return stack
    }()
    
    lazy var foodInfoStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.addArrangedSubview(foodDescriptionLabel)
        stack.addArrangedSubview(foodPriceAndWeightStackView)
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 10
        
        return stack
    }()
    
    lazy var pepperImageView: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "pepper")
        image.isHidden = true
        
        return image
    }()
    
    lazy var bascetButton: UIButton = {
        let button = UIButton(configuration: .filled())
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("В корзину", for: .normal)
        
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(views: foodImageView, foodNameLabel, foodInfoStackView, pepperImageView, bascetButton)
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(subMenuItem: SubMenuItem?) {
        let baseUrl = "https://vkus-sovet.ru"
        let partialImageUrl = subMenuItem?.image ?? ""
        
        guard let fullImageUrl = URL(string: baseUrl + partialImageUrl) else { return }
        
        foodNameLabel.text = subMenuItem?.name
        foodDescriptionLabel.text = subMenuItem?.content
        foodWeightLabel.text = "/ \(subMenuItem?.weight ?? "0")"
        pepperImageView.isHidden = subMenuItem?.spicy == nil ? true : false
        
        if let priceString = subMenuItem?.price, let price = Float(priceString) {
            foodPriceLabel.text = "\(Int(price)) ₽ "
        }
        
        networkManager.fetchImage(withUrl: fullImageUrl, andImage: foodImageView)
        
    }
    
    func setup(views: UIView...) {
        views.forEach { newView in
            contentView.addSubview(newView)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                foodImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                foodImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                foodImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                foodNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                foodNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                foodNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                foodInfoStackView.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor, constant: 5),
                foodInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                foodInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                foodInfoStackView.bottomAnchor.constraint(equalTo: foodImageView.topAnchor, constant: -5)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                pepperImageView.bottomAnchor.constraint(equalTo: foodImageView.topAnchor, constant: -5),
                pepperImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                pepperImageView.heightAnchor.constraint(equalToConstant: 20),
                pepperImageView.widthAnchor.constraint(equalToConstant: 20)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                bascetButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                bascetButton.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: -20),
                bascetButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.20),
                bascetButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8)
            ]
            
        )
        
    }
}
