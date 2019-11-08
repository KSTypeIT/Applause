//
//  RepositoryCollectionViewModelTests.swift
//  ApplauseTests
//
//  Created by Sokolowski, Kamil on 08/11/2019.
//  Copyright © 2019 TypeIT Kamil Sokołowski. All rights reserved.
//

import XCTest
@testable import Applause

class RepositoryCollectionViewModelTests: XCTestCase, RepositoryCollectionViewModelDelegate {

    let viewModel = RepositoryCollectionViewModel(dataProvider: DataProviderMock())
    var reloadCount: Int = 0

    override func setUp() {
        reloadCount = 0
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        viewModel.viewDidLoad()
        viewModel.delegate = self
        viewModel.findRepository("xxx")

        XCTAssertEqual(viewModel.getFilteredRepositories().count, 0)
        XCTAssertEqual(viewModel.getRepositories().count, 5)
        XCTAssertEqual(reloadCount, 1)
    }

    func repositoriesReload() {
        //If delegate works
        reloadCount+=1
    }

    func reqestFailed() {
          //
    }

}


class DataProviderMock: DataProviding {
    private let repositories: [Repository]
    private let testRepo: Repository

    init() {
        testRepo = Repository(id: 123, name: "TestRepo", url: "TestURL", size: 123, description: "Test Description", language: "Swift 5")
        repositories = Array(repeating: testRepo, count: 5)
    }

    func requestAllRepositories(completionHandler: @escaping ([Repository]) -> Void, errorHandler: @escaping (RequestError) -> Void) {
        completionHandler(repositories)
    }
}
