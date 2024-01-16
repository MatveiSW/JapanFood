//
//  Extension + FoodListViewControllerSetupConstraints.swift
//  JapanFood
//
//  Created by Матвей Авдеев on 16.01.2024.
//

import UIKit

extension FoodListViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                categoriesFoodCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                categoriesFoodCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                categoriesFoodCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                categoriesFoodCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                categoriesNameLabel.topAnchor.constraint(equalTo: categoriesFoodCollectionView.bottomAnchor, constant: 20),
                categoriesNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                categoriesNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                foodListCollectionView.topAnchor.constraint(equalTo: categoriesNameLabel.bottomAnchor, constant: 10),
                foodListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                foodListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                foodListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
}
