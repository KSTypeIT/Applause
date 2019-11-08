//
//  ViewController.swift
//  Applause
//
//  Created by Sokolowski, Kamil on 07/11/2019.
//  Copyright © 2019 TypeIT Kamil Sokołowski. All rights reserved.
//

import UIKit

private enum Constans: CGFloat {
    case cellHeight = 200
    case minimumLineSpacing = 10
}

fileprivate enum Static: String {
    case cellReuseIdentifier = "kRepositoryCell"
    case cellNibName = "RepositoryCollectionViewCell"
}

final class RepositoryCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let searchController = UISearchController(searchResultsController: nil)

    let viewModel = RepositoryCollectionViewModel()

    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchControllerSetup()
        defineCollectionViewLayout()
        collectionView.register(UINib(nibName: Static.cellNibName.rawValue, bundle: nil),
                                forCellWithReuseIdentifier: Static.cellReuseIdentifier.rawValue)

        viewModel.delegate = self
        viewModel.viewDidLoad()
    }

    private func defineCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: Constans.cellHeight.rawValue)
        layout.minimumLineSpacing = Constans.minimumLineSpacing.rawValue
        collectionView!.collectionViewLayout = layout
    }

    private func searchControllerSetup() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension RepositoryCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltering ? viewModel.getFilteredRepositories().count : viewModel.getRepositories().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RepositoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Static.cellReuseIdentifier.rawValue,
                                                                                    for: indexPath) as! RepositoryCollectionViewCell
        cell.setupWith(repository: viewModel.getRepositoryAtIndex(indexPath: indexPath, filtered: isFiltering))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // If this app was made to be bigger this should be propobally handeled by some Flow Controller
        let repository = viewModel.getRepositoryAtIndex(indexPath: indexPath, filtered: isFiltering)
        let viewModel = RepositoryDetailsViewModel(repository: repository)
        let repositoryDetailsVC = RepositoryDetailsViewController(repositoryDetailsViewModel: viewModel)
        self.navigationController?.pushViewController(repositoryDetailsVC, animated: true)
    }
}

extension RepositoryCollectionViewController: RepositoryCollectionViewModelDelegate {
    func repositoriesReload() {
        collectionView.reloadData()
    }
}

extension RepositoryCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        viewModel.findRepository(searchBar.text!)
    }
}

