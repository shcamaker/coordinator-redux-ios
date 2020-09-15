//
//  ReduxMessageStore.swift
//  RxStateDemo
//
//  Created by 沈海超 on 2020/4/5.
//  Copyright © 2020年 沈海超. All rights reserved.
//

import Foundation
import ReSwift

/// Redux中的状态是集中式储存的，所以这里的newsStore要定义成一个全局变量，每个不同的State类型都有一个对应的Store
let messageStore = ReSwift.Store<ReduxMessageState>(reducer: reduxMessageReducer, state: nil)


