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

final class RepositoryCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let viewModel = RepositoryCollectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defineLayout()
        collectionView.register(UINib(nibName: "RepositoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "kRepositoryCell")
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }

    private func defineLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: Constans.cellHeight.rawValue)
        layout.minimumLineSpacing = Constans.minimumLineSpacing.rawValue
        collectionView!.collectionViewLayout = layout
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
        let cell: RepositoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "kRepositoryCell", for: indexPath) as! RepositoryCollectionViewCell
        cell.setupWith(repository: viewModel.getRepositoryAtIndex(indexPath: indexPath))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

    }
}

