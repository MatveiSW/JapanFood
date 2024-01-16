//
//  SubMenu.swift
//  JapanFood
//
//  Created by Матвей Авдеев on 17.01.2024.
//

import Foundation

struct SubMenu: Codable {
    let status: Bool
    let menuList: [SubMenuItem]
}

struct SubMenuItem: Codable {
    let id: String
    let image: String
    let name: String
    let content: String
    let price: String
    let weight: String?
    let spicy: String?
}
