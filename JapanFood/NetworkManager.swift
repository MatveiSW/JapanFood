//
//  NetworkManager.swift
//  JapanFood
//
//  Created by Матвей Авдеев on 16.01.2024.
//

import UIKit
import Kingfisher

enum Link {
    case menuCategories
    case subMenu
    
    var url: URL {
        switch self {
            
        case .menuCategories:
            return URL(string: "https://vkus-sovet.ru/api/getMenu.php")!
        case .subMenu:
            return URL(string: "https://vkus-sovet.ru/api/getSubMenu.php")!
        }
    }
}

enum NetworkError: Error {
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchCategories(withUrl url: URL, completion: @escaping(Result<CategoriesMenu, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let networkData = try decoder.decode(CategoriesMenu.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(networkData))
                }
            } catch {
                print(error.localizedDescription)
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    
    func fetchImage(withUrl url: URL, andImage image: UIImageView) {
        image.kf.setImage(with: url)
    }
    
    func fetchSubMenu(for menuId: String, completion: @escaping(Result<SubMenu, NetworkError>) -> Void) {
       
        var components = URLComponents(url: Link.subMenu.url, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "menuID", value: menuId)]
        
        guard let url = components?.url else {
            completion(.failure(.noData))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            
           guard let data = data else {
               
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
               
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {

                let networkData = try decoder.decode(SubMenu.self, from: data)
               
                DispatchQueue.main.async {
                    completion(.success(networkData))
                }
            } catch {
                print(error.localizedDescription)
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    private init() {}
}
