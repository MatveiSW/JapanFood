//
//  Menu.swift
//  JapanFood
//
//  Created by Матвей Авдеев on 16.01.2024.
//

import Foundation

struct CategoriesMenu: Decodable {
    let status: Bool
    let menuList: [CategoriesMenuItem]
}

struct CategoriesMenuItem: Decodable {
    let menuID: String
    let image: String
    let name: String
    let subMenuCount: Int
}

