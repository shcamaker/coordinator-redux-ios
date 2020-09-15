//
//  DIContainer.swift
//  MVVM+Coordinator+RxSwift
//
//  Created by 沈海超 on 2020/9/14.
//  Copyright © 2020 沈海超. All rights reserved.
//

import UIKit
import Swinject

struct DIContainer {
     static let container: Container = {
        let container = Container()
        container.register(GithubProtocol.self) { _ in GithubService() }
        container.register(GithubManager.self) { r in GithubManager(githubService: r.resolve(GithubProtocol.self)!) }
        container.register(RepositoryListViewModel.self) { r in
            RepositoryListViewModel(initialLanguage: "Swift", githubManager: r.resolve(GithubManager.self)!)
        }
        container.register(RepositoryListViewController.self) { r in
            return RepositoryListViewController.initFromStoryboard(name: "Main")
        }
        return container
    }()
}
