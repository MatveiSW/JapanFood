//
//  CategoriesCollectionViewCell.swift
//  JapanFood
//
//  Created by Матвей Авдеев on 16.01.2024.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    let networkManager = NetworkManager.shared
    
    lazy var categoriesImageView: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    lazy var categoriesNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.4
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var categoriesCountLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        
        return label
    }()
    
    lazy var categoriesStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(categoriesNameLabel)
        stack.addArrangedSubview(categoriesCountLabel)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    override var isSelected: Bool {
            didSet {
                contentView.backgroundColor = isSelected ? UIColor(named: "selectedCellColor") : UIColor(named: "categoriesCellColor")
            }
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        settingContentView()
        
        setup(views: categoriesImageView, categoriesStackView)
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(categoriesMenu: CategoriesMenuItem?) {
        let baseUrl = "https://vkus-sovet.ru"
        let partialImageUrl = categoriesMenu?.image ?? ""
        
        guard let fullImageUrl = URL(string: baseUrl + partialImageUrl) else { return }
        
        var secondaryText = ""
        let subMenuNumber = Int(categoriesMenu?.subMenuCount ?? 0)
        secondaryText = subMenuNumber == 1 ? "товар" : "товаров"
        
        categoriesNameLabel.text = categoriesMenu?.name
        categoriesCountLabel.text = "\(categoriesMenu?.subMenuCount ?? 0) \(secondaryText)"
        
        networkManager.fetchImage(withUrl: fullImageUrl, andImage: categoriesImageView)

    }
    
    private func settingContentView() {
        contentView.backgroundColor = UIColor(named: "categoriesCellColor")
        contentView.layer.cornerRadius = 10
    }
    
    private func setup(views: UIView...) {
        views.forEach { newView in
            contentView.addSubview(newView)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                categoriesImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                categoriesImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                categoriesImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                categoriesImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                categoriesStackView.topAnchor.constraint(equalTo: categoriesImageView.bottomAnchor, constant: 10),
                categoriesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
                categoriesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                categoriesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5)
            ]
        )
    }
}
