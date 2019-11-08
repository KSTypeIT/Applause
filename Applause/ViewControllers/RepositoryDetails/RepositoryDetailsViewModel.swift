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

    internal var name: String {
        repository.name
    }
    internal var id: String {
        repository.id.description
    }
    internal var url: String {
        repository.url
    }
    internal var size: Int {
        repository.size
    }
    internal var description: String? {
        repository.description
    }
    internal var language: String? {
        repository.language
    }
}
