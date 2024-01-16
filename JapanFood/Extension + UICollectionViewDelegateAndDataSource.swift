//
//  Extension + UICollectionViewDelegateAndDataSource.swift
//  JapanFood
//
//  Created by Матвей Авдеев on 16.01.2024.
//

import UIKit

extension FoodListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        collectionView == categoriesFoodCollectionView ? categoriesMenu?.menuList.count ?? 10 : subMenu?.menuList.count ?? 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoriesFoodCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoriesIdentifier, for: indexPath) as? CategoriesCollectionViewCell else { return UICollectionViewCell() }
                        
            cell.configure(categoriesMenu: categoriesMenu?.menuList[indexPath.row])

            return cell
            
        } else if collectionView == foodListCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: foodListIdentifier, for: indexPath) as? FoodListCollectionViewCell else { return UICollectionViewCell() }
            
            cell.backgroundColor = .black
            cell.layer.cornerRadius = 10
            
            cell.configure(subMenuItem: subMenu?.menuList[indexPath.row])
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoriesFoodCollectionView {
            
            let width = collectionView.frame.width / 3 - 12
            let height = collectionView.frame.height / 1.1
            
            return CGSize(width: width, height: height)
            
        }
        
        let width = collectionView.frame.width / 2 - 24
        let height = collectionView.frame.height / 2.4
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesFoodCollectionView {
            
            fetchSubMenu(forMenuId: categoriesMenu?.menuList[indexPath.row].menuID ?? "")
            categoriesNameLabel.text = categoriesMenu?.menuList[indexPath.row].name
            
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCollectionViewCell {
                cell.isSelected = true
            }
        }
    }
}
