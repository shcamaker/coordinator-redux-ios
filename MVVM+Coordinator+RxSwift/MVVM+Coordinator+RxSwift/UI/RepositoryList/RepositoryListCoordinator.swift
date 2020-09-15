//
//  RepositoryListCoordinator.swift
//  RepoSearcher
//
//  Created by 沈海超 on 6/30/19.
//  Copyright © 2019 沈海超. All rights reserved.
//

import UIKit
import RxSwift
import SafariServices

class RepositoryListCoordinator: BaseCoordinator<Void> {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
//        let githubManager = GithubManager(githubService: GithubService())
//        let viewModel = RepositoryListViewModel(initialLanguage: "Swift", githubManager: githubManager)
//        let viewController = RepositoryListViewController.initFromStoryboard(name: "Main")
//        viewController.viewModel = viewModel
//        let navigationController = UINavigationController(rootViewController: viewController)
        let viewModel = DIContainer.container.resolve(RepositoryListViewModel.self)!
        let viewController = DIContainer.container.resolve(RepositoryListViewController.self)!
        viewController.viewModel = viewModel
        let navigationController = UINavigationController(rootViewController: viewController)
        
        //跳转逻辑
        viewModel.alertMessage
        .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in self?.presentAlert(viewController: viewController, message: $0) })
        .disposed(by: disposeBag)

        viewModel.showRepositoryDetail
            .map { $0.url }
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.showRepositoryDetail(by: $0, in: navigationController) })
            .disposed(by: disposeBag)

        viewModel.showLanguageList
            .flatMap { [weak self] _ -> Observable<String?> in
                guard let self = self else { return .empty() }
                return self.showLanguageList(on: viewController)
            }
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: viewModel.setCurrentLanguage)
            .disposed(by: disposeBag)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return Observable.empty()
    }
    
    private func presentAlert(viewController: UIViewController, message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alertController, animated: true)
    }
    
    private func showRepositoryDetail(by url: URL, in navigationController: UINavigationController) {
        let safariViewController = SFSafariViewController(url: url)
        navigationController.pushViewController(safariViewController, animated: true)
    }

    private func showLanguageList(on rootViewController: UIViewController) -> Observable<String?> {
        let languageListCoordinator = LanguageListCoordinator(rootViewController: rootViewController)
        return coordinate(to: languageListCoordinator)
            .map { result in
                switch result {
                case .language(let language): return language
                case .cancel: return nil
                }
            }
    }
    
    deinit {
        print("RepositoryListCoordinator deinit")
    }
}
