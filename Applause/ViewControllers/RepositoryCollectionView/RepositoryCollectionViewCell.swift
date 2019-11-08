//
//  RepositoryCollectionViewCell.swift
//  Applause
//
//  Created by Sokolowski, Kamil on 08/11/2019.
//  Copyright © 2019 TypeIT Kamil Sokołowski. All rights reserved.
//

import UIKit

class RepositoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var urlLabel: UILabel!
    @IBOutlet private weak var idString: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func setupWith(repository: Repository) {
        urlLabel.text = repository.url
        idString.text = repository.id.description
        nameLabel.text = repository.name
    }

}
