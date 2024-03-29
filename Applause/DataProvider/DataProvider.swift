//
//  DataProvider.swift
//  Applause
//
//  Created by Sokolowski, Kamil on 07/11/2019.
//  Copyright © 2019 TypeIT Kamil Sokołowski. All rights reserved.
//

import Foundation

public enum RequestError: Error {
    case badURL
    case requestFailed(Error?)
    case brokenData
}

fileprivate enum EndpointURL: String {
    case apiUrl = "https://api.github.com"
    case allRepositories = "/orgs/applauseoss/repos?per_page=10"
}

public protocol DataProviding {
    func requestAllRepositories(completionHandler: @escaping ([Repository]) -> Void, errorHandler: @escaping (RequestError) -> Void)
}

final class DataProvider: DataProviding {

    private let session: URLSession = URLSession.shared

    internal func requestAllRepositories(completionHandler: @escaping ([Repository]) -> Void,
                             errorHandler: @escaping (RequestError) -> Void) {

        guard let url =  URL(string: EndpointURL.apiUrl.rawValue + EndpointURL.allRepositories.rawValue) else {
            errorHandler(RequestError.badURL)
            return
        }
        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { data, response, error in

            guard error == nil else {
                errorHandler(.requestFailed(nil))
                return
            }
            guard let data = data else {
                errorHandler(.brokenData)
                return
            }
            do {
                let repositories = try JSONDecoder().decode([Repository].self, from: data)
                completionHandler(repositories)
            } catch let error as NSError {
                errorHandler(.requestFailed(error))
            }
        }
        task.resume()
    }
}
