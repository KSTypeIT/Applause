//
//  RepositoryCollectionViewModel.swift
//  Applause
//
//  Created by Sokolowski, Kamil on 08/11/2019.
//  Copyright © 2019 TypeIT Kamil Sokołowski. All rights reserved.
//

import Foundation

protocol RepositoryCollectionViewModelDelegate: AnyObject {
    func repositoriesDownloaded()
}

protocol RepositoryCollectionViewModelProtocol {
    func viewDidLoad()
    func getRepositories() -> [Repository]
    func getRepositoryAtIndex(indexPath: IndexPath) -> Repository
    func findRepository(_ searchString: String) -> Repository
}

final class RepositoryCollectionViewModel {
    weak var delegate: RepositoryCollectionViewModelDelegate?

    private let dataProvider: DataProviding
    private var repositories: [Repository] = []

    init (dataProvider: DataProviding = DataProvider()){
        self.dataProvider = dataProvider
    }

    public func viewDidLoad() {
        dataProvider.requestAllRepositories(completionHandler: { [weak self] repositories in
            self?.repositories = repositories
            self?.delegate?.repositoriesDownloaded()
        }, errorHandler: { _ in
            //
        })
    }

    public func getRepositories() -> [Repository] {
        return self.repositories
    }

    public func getRepositoryAtIndex(indexPath: IndexPath) -> Repository {
        self.repositories[indexPath.row]
    }

    public func findRepository(_ searchString: String) -> Repository {
        Repository(id: 1, name: "", url: "", size: 12)
    }
}
