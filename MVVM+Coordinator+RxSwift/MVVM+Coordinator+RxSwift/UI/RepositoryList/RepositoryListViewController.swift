//
//  RepositoryListViewController.swift
//  RepoSearcher
//
//  Created by 沈海超 on 6/29/19.
//  Copyright © 2019 沈海超. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

/// Shows a list of most starred repositories filtered by language.
class RepositoryListViewController: UIViewController, StoryboardInitializable {

    @IBOutlet private weak var tableView: UITableView!
    private let chooseLanguageButton = UIBarButtonItem(barButtonSystemItem: .organize, target: nil, action: nil)
    private let refreshControl = UIRefreshControl()

    var viewModel: RepositoryListViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        refreshControl.sendActions(for: .valueChanged)
    }

    private func setupUI() {
        navigationItem.rightBarButtonItem = chooseLanguageButton
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.insertSubview(refreshControl, at: 0)
    }

    private func setupBindings() {
        viewModel.repositories
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
            .bind(to: tableView.rx.items(cellIdentifier: "RepositoryCell", cellType: RepositoryCell.self)) { [weak self] (_, repo, cell) in
                self?.setupRepositoryCell(cell, repository: repo)
            }
            .disposed(by: disposeBag)

        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)

        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.reload)
            .disposed(by: disposeBag)

        chooseLanguageButton.rx.tap
            .bind(to: viewModel.showLanguageList)
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(RepositoryViewModel.self)
            .bind(to: viewModel.showRepositoryDetail)
            .disposed(by: disposeBag)
    }

    private func setupRepositoryCell(_ cell: RepositoryCell, repository: RepositoryViewModel) {
        print("cellSetupThread:",Thread.current)
        cell.selectionStyle = .none
        cell.setName(repository.name)
        cell.setDescription(repository.description)
        cell.setStarsCountTest(repository.starsCountText)
    }
}
