//
//  GithubManager.swift
//  MVVM+Coordinator+RxSwift
//
//  Created by 沈海超 on 2020/9/14.
//  Copyright © 2020 沈海超. All rights reserved.
//

import UIKit
import RxSwift

struct GithubManager {

    let githubService: GithubProtocol
    init(githubService: GithubProtocol) {
        self.githubService = githubService
    }
    
    func getLanguageList() -> Observable<[String]> {
        return githubService.getLanguageList()
    }
    
    func getMostPopularRepositories(byLanguage language: String) -> Observable<[Repository]> {
        return githubService.getMostPopularRepositories(byLanguage: language)
    }
}
