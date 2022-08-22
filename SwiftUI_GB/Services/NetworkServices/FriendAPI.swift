//
//  FriendService.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 16.08.2022.
//

import Foundation
import SwiftUI

protocol FriendsService {
    func loadFriend(completion: @escaping ((Result<FriendsContainer, FriendsError>) ->()))
}

enum FriendsError: Error {
    case parseError
    case requestError(Error)
}

fileprivate enum TypeMethods: String {
    case friendsGet = "/method/friends.get"
}

fileprivate enum TypeRequests: String {
    case get = "GET"
    case post = "POST"
}

final class FriendAPI: FriendsService {
    
    @ObservedObject var tokenSession = Session.shared
    
    private let scheme = "https"
    private let host = "api.vk.com"
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
        
    func loadFriend(completion: @escaping ((Result<FriendsContainer, FriendsError>) ->())){
         guard let token = tokenSession.token else {
            return
        }
        let params: [String: String] = ["v": "5.131",
                                        "access_token": token,
                                        "fields": "photo_50"
        ]
        
        let url = configureUrl(token: token,
                               method: .friendsGet,
                               htttpMethod: .get,
                               params: params)
        print(url)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.requestError(error)))
            }
            
            guard let data = data else { return }
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(FriendsContainer.self, from: data)
                print(result)
                return completion(.success(result))
            } catch {
                return completion(.failure(.parseError))
            }
            
        }
        task.resume()
    }
}

private extension FriendAPI {
    func configureUrl(token: String,
                      method: TypeMethods,
                      htttpMethod: TypeRequests,
                      params: [String: String]) -> URL {
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "access_token", value: tokenSession.token ))
        queryItems.append(URLQueryItem(name: "v", value: "5.131"))
        
        for (param, value) in params {
            queryItems.append(URLQueryItem(name: param, value: value))
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = method.rawValue
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            fatalError("URL id invalid")
        }
        return url
    }
}
