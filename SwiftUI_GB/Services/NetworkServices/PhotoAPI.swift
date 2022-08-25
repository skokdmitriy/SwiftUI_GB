//
//  PhotoAPI.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 22.08.2022.
//

import Foundation
import SwiftUI

protocol PhotoService {
    func loadPhoto(idFriend: Int, completion: @escaping ([InfoPhotoFriend]) -> Void)
}

enum PhotosError: Error {
case parseError
case requestError(Error)
}

fileprivate enum TypeMethods: String {
case photosGetAll = "/method/photos.getAll"
}

fileprivate enum TypeRequests: String {
    case get = "GET"
    case post = "POST"
}

class PhotoApi: PhotoService {
    
    @ObservedObject var tokenSession = Session.shared

    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    private let scheme = "https"
    private let host = "api.vk.com"
    private let decoder = JSONDecoder()
    
    func loadPhoto(idFriend: Int, completion: @escaping ([InfoPhotoFriend]) -> Void) {
        guard let token = tokenSession.token else { return }
        
        let params: [String: String] = ["owner_id": "\(idFriend)",
                                        "extended": "1",
                                        "count": "200"]
        
        let url = configureUrl(token: token,
                               method: .photosGetAll,
                               httpMethod: .get,
                               params: params)
        print("FOTO++++++++++ \(url)")
        let task = session.dataTask(with: url) { data, response, error in
//            if let error = error {
//                return completion(.failure(.requestError(error)))
//            }
            guard let data = data else {
                return
            }
            do {
                let result = try self.decoder.decode(PhotoFriends.self, from: data)
                print(result)
                
                let photos = result.response.items
                completion(photos)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

private extension PhotoApi {
    func configureUrl(token: String,
                      method: TypeMethods,
                      httpMethod: TypeRequests,
                      params: [String: String]) -> URL {
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "access_token", value: token))
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
            fatalError("URL is invalid")
        }
        return url
    }
}

