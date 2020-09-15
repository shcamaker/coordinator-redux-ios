//
//  MessageProvider.swift
//  RxStateDemo
//
//  Created by 沈海超 on 2020/3/18.
//  Copyright © 2020年 沈海超. All rights reserved.
//

import Foundation
import Moya

let MessageProvider = NetworkProvider<MessageTarget>()

enum MessageTarget {
    case news
}

extension MessageTarget: TargetType {
    var method: Moya.Method {
        return .get
    }
    
    var path: String {
        switch self {
        case .news:
            return "test"
        }
    }
    
    var task: Task {
        switch self {
        case .news:
            return .requestPlain
        }
    }
}

