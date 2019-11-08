//
//  ViewController.swift
//  Applause
//
//  Created by Sokolowski, Kamil on 07/11/2019.
//  Copyright © 2019 TypeIT Kamil Sokołowski. All rights reserved.
//

import UIKit

final class RepositoryCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let viewModel = RepositoryCollectionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension RepositoryCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, RepositoryCollectionViewModelDelegate {
    func repositoriesDownloaded() {
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getRepositories().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let repository = viewModel.getRepositories()[indexPath.row]
        
    }
}

