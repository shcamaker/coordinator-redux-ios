//
//  BaseCoordinator.swift
//  RepoSearcher
//
//  Created by 沈海超 on 6/29/19.
//  Copyright © 2019 沈海超. All rights reserved.
//

import RxSwift
import Foundation

class BaseCoordinator<ResultType> {

    typealias CoordinationResult = ResultType

    let disposeBag = DisposeBag()

    private let identifier = UUID()

    private var childCoordinators = [UUID: Any]()

    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }

    func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in
                self?.free(coordinator: coordinator)
                
            })
    }

    
    func start() -> Observable<CoordinationResult> {
        fatalError("Start method should be implemented.")
    }
}
