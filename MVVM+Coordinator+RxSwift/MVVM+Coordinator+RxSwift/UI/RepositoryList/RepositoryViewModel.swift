//
//  RepositoryViewModel.swift
//  RepoSearcher
//
//  Created by 沈海超 on 6/29/19.
//  Copyright © 2019 沈海超. All rights reserved.
//

import Foundation

class RepositoryViewModel {
    let name: String
    let description: String
    let starsCountText: String
    let url: URL

    init(repository: Repository) {
        self.name = repository.fullName
        self.description = repository.description
        self.starsCountText = "⭐️ \(repository.starsCount)"
        self.url = URL(string: repository.url)!
    }
}
