//
//  AppDelegate.swift
//  MVVM+Coordinator+RxSwift
//
//  Created by 沈海超 on 2020/8/23.
//  Copyright © 2020 沈海超. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator!
    private let disposeBag = DisposeBag()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()

       appCoordinator = AppCoordinator(window: window!)
       appCoordinator.start()
                   .subscribe()
                   .disposed(by: disposeBag)
        return true
        
    }


}

