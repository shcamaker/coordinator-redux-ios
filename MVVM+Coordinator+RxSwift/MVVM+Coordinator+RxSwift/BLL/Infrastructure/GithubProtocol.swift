//
//  GithubProtocol.swift
//  MVVM+Coordinator+RxSwift
//
//  Created by 沈海超 on 2020/9/14.
//  Copyright © 2020 沈海超. All rights reserved.
//

import Foundation
import RxSwift

protocol GithubProtocol {
    func getLanguageList() -> Observable<[String]>
    func getMostPopularRepositories(byLanguage language: String) -> Observable<[Repository]>
}
