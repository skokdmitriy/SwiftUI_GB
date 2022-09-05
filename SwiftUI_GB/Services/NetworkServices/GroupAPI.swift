//
//  GroupAPI.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 21.08.2022.
//

import Foundation
import SwiftUI

protocol GroupService {
    func loadGroups(completion: @escaping (Result<SearchGroup, GroupError>) -> Void)
}

enum GroupError: Error {
    case parseError
    case requestError(Error)
}

fileprivate enum TypeMethods: String {
    case groupsGet = "/method/groups.get"
}

fileprivate enum TypeRequests: String {
    case get = "GET"
    case post = "POST"
}

class GroupAPI: GroupService {
    
    @ObservedObject var tokenSession = Session.shared
    
    private let scheme = "https"
    private let host = "api.vk.com"
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    func loadGroups(completion: @escaping (Result<SearchGroup, GroupError>) -> Void) {
        guard let token = tokenSession.token else { return }
        
        let params: [String: String] = ["extended": "1"]
        
        let url = configureUrl(token: token,
                               method: .groupsGet,
                               httpMethod: .get,
                               params: params)
        print(url)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.requestError(error)))
            }
            
            guard let data = data else { return }
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(SearchGroup.self, from: data)
                print(result)
                return completion(.success(result))
            } catch {
                return completion(.failure(.parseError))
            }
            
        }
        task.resume()
    }
}

private extension GroupAPI {
    func configureUrl(token: String,
                      method: TypeMethods,
                      httpMethod: TypeRequests,
                      params: [String: String]) -> URL {
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "access_token", value: tokenSession.token))
        queryItems.append(URLQueryItem(name: "v", value: tokenSession.versionApi))
        
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
