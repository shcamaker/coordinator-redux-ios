//
//  RepositoryListViewModel.swift
//  RepoSearcher
//
//  Created by 沈海超 on 6/29/19.
//  Copyright © 2019 沈海超. All rights reserved.
//

import Foundation
import RxSwift

class RepositoryListViewModel {

    let setCurrentLanguage: AnyObserver<String>

    let reload: PublishSubject<Void> = PublishSubject<Void>()

    let repositories: Observable<[RepositoryViewModel]>

    let title: Observable<String>

    let alertMessage: PublishSubject<String>

    let showRepositoryDetail: PublishSubject<RepositoryViewModel> = PublishSubject<RepositoryViewModel>()

    let showLanguageList: PublishSubject<Void> = PublishSubject<Void>()

    init(initialLanguage: String, githubManager: GithubManager) {

        let _currentLanguage = BehaviorSubject<String>(value: initialLanguage)
        self.setCurrentLanguage = _currentLanguage.asObserver()
        self.title = _currentLanguage.asObservable()
        
        let _alertMessage = PublishSubject<String>()
        self.alertMessage = _alertMessage
        
        self.repositories = Observable.combineLatest( self.reload, _currentLanguage) { $1 }
            .flatMapLatest {
               githubManager.getMostPopularRepositories(byLanguage: $0)
                    .catchError {
                        print("errorThread:",Thread.current)//errorThread: <NSThread: 0x6000003b4240>{number = 7, name = (null)}
                        _alertMessage.onNext($0.localizedDescription)
                        return Observable.empty()
               }
            }
        .compactMap { $0.map(RepositoryViewModel.init) }
        
    }
}
