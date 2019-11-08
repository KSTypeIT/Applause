//
//  RepositoryDetailsViewController.swift
//  Applause
//
//  Created by Sokolowski, Kamil on 08/11/2019.
//  Copyright © 2019 TypeIT Kamil Sokołowski. All rights reserved.
//

import Foundation
import UIKit

fileprivate enum Static: String {
    case xibName = "RepositoryDetailsViewController"
}

final class RepositoryDetailsViewController: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var lanugaeLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var urlLabel: UILabel!

    private let viewModel: RepositoryDetailsViewModelProtocol

    init(repositoryDetailsViewModel: RepositoryDetailsViewModelProtocol) {
        self.viewModel = repositoryDetailsViewModel
        super.init(nibName: Static.xibName.rawValue, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }

    private func setUp() {
        nameLabel.text = "Name: \(viewModel.name)"
        idLabel.text = "Repository id: \(viewModel.id)"
        lanugaeLabel.text = "Language: \(viewModel.language ?? "")"
        descriptionLabel.text = "Description: \(viewModel.description ?? "")"
        urlLabel.text = viewModel.url
    }
}
