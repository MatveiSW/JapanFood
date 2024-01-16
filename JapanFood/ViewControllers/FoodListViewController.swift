//
//  ViewController.swift
//  JapanFood
//
//  Created by Матвей Авдеев on 16.01.2024.
//

import UIKit

class FoodListViewController: UIViewController {
    
    let categoriesIdentifier = "categories"
    let foodListIdentifier = "food"
    
    let networkManager = NetworkManager.shared
    
    var categoriesMenu: CategoriesMenu? {
            didSet {
                if let firstCategoryID = categoriesMenu?.menuList.first?.menuID {
                    fetchSubMenu(forMenuId: firstCategoryID)
                    categoriesNameLabel.text = categoriesMenu?.menuList.first?.name
                }
            }
        }
    
    var subMenu: SubMenu?
    
    lazy var categoriesFoodCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: categoriesIdentifier)
        collection.backgroundColor = .clear

        return collection
    }()
    
    lazy var categoriesNameLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Суши"
        label.font = .boldSystemFont(ofSize: 35)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.4
        
        return label
    }()
    
    lazy var foodListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 40, right: 16)
        layout.minimumLineSpacing = view.frame.height / 20 
        layout.minimumInteritemSpacing = 16
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(FoodListCollectionViewCell.self, forCellWithReuseIdentifier: foodListIdentifier)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor(named: "backgroundColor")
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        settingNavigationBar()
        
        setup(views: categoriesFoodCollectionView, categoriesNameLabel, foodListCollectionView)
        setupConstraints()
        
        fetchCategories()
        
    }
    
    func fetchCategories() {
        networkManager.fetchCategories(withUrl: Link.menuCategories.url) { [weak self] result in
            switch result {
                
            case .success(let categoriesData):
                self?.categoriesMenu = categoriesData
                DispatchQueue.main.async {
                    self?.categoriesFoodCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchSubMenu(forMenuId menuId: String) {
        networkManager.fetchSubMenu(for: menuId) { [weak self] result in
            switch result {
                
            case .success(let subMenuData):
                self?.subMenu = subMenuData
                DispatchQueue.main.async {
                    self?.foodListCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func settingNavigationBar() {
        
        let barButtonImage = UIImageView()
        barButtonImage.image = UIImage(named: "vkussovet")
        
        let barButtonLabel = UILabel()
        barButtonLabel.text = "VKUSSOVET"
        barButtonLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        barButtonLabel.textColor = .white
        
        navigationItem.leftBarButtonItems =
        [
            UIBarButtonItem(customView: barButtonImage),
            UIBarButtonItem(customView: barButtonLabel)
        ]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "phone"), style: .plain, target: self, action: nil)
        
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    private func setup(views: UIView...) {
        views.forEach { newView in
            view.addSubview(newView)
        }
    }
    
}

