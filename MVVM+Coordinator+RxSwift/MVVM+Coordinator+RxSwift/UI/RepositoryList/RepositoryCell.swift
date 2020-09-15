//
//  RepositoryCell.swift
//  RepoSearcher
//
//  Created by 沈海超 on 6/29/19.
//  Copyright © 2019 沈海超. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var starsCountLabel: UILabel!
    
    func setName(_ name: String) {
        nameLabel.text = name
    }

    func setDescription(_ description: String) {
        descriptionLabel.text = description
    }

    func setStarsCountTest(_ starsCountText: String) {
        starsCountLabel.text = starsCountText
    }
}
