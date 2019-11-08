//
//  RepositoryCollectionViewModel.swift
//  Applause
//
//  Created by Sokolowski, Kamil on 08/11/2019.
//  Copyright © 2019 TypeIT Kamil Sokołowski. All rights reserved.
//

import Foundation

protocol RepositoryCollectionViewModelDelegate: AnyObject {
    func repositoriesReload()
    func reqestFailed()
}

protocol RepositoryCollectionViewModelProtocol {
    func viewDidLoad()
    func getRepositories() -> [Repository]
    func getFilteredRepositories() -> [Repository] 
    func getRepositoryAtIndex(indexPath: IndexPath, filtered: Bool) -> Repository
    func findRepository(_ searchString: String)
}

final class RepositoryCollectionViewModel: RepositoryCollectionViewModelProtocol {

    public weak var delegate: RepositoryCollectionViewModelDelegate?

    private let dataProvider: DataProviding
    private var repositories: [Repository] = []
    private var filteredRepositories: [Repository] = []

    init (dataProvider: DataProviding = DataProvider()) {
        self.dataProvider = dataProvider
    }

    internal func viewDidLoad() {
        //this is called here since we need data to work with. Could happen in some Loading Controller before we load the RepositoyColectionVC.

        dataProvider.requestAllRepositories(completionHandler: { [weak self] repositories in
            self?.repositories = repositories
             DispatchQueue.main.async {
                self?.delegate?.repositoriesReload()
             }
        }, errorHandler: { [weak self] _ in
            DispatchQueue.main.async {
                self?.delegate?.reqestFailed()
            }
        })
    }

    internal func getRepositories() -> [Repository] {
        return self.repositories
    }

    internal func getFilteredRepositories() -> [Repository] {
           return self.filteredRepositories
       }

    internal func getRepositoryAtIndex(indexPath: IndexPath, filtered: Bool) -> Repository {
        if filtered {
           return self.filteredRepositories[indexPath.row]
        }
        return self.repositories[indexPath.row]
    }

    internal func findRepository(_ searchString: String) {
        self.filteredRepositories = self.repositories.filter {
            $0.name.range(of: searchString, options: .caseInsensitive) != nil
        }
        self.delegate?.repositoriesReload()
    }
}
