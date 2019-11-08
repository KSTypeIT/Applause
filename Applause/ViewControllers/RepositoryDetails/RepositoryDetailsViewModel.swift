//
//  RepositoryDetailsViewModel.swift
//  Applause
//
//  Created by Sokolowski, Kamil on 08/11/2019.
//  Copyright © 2019 TypeIT Kamil Sokołowski. All rights reserved.
//

import Foundation

protocol RepositoryDetailsViewModelProtocol {
    var name: String { get }
    var id: String { get }
    var url: String { get }
    var size: Int { get }
    var description: String? { get }
    var language: String? { get }
}

struct RepositoryDetailsViewModel: RepositoryDetailsViewModelProtocol {

    private let repository: Repository

    init(repository: Repository){
        self.repository = repository
    }

    var name: String {
        repository.name
    }
    var id: String {
        repository.id.description
    }
    var url: String {
        repository.url
    }
    var size: Int {
        repository.size
    }
    var description: String? {
        repository.description
    }
    var language: String? {
        repository.language
    }
}
