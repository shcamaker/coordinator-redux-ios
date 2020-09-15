//
//  Moya+Extension.swift
//  RxStateDemo
//
//  Created by 沈海超 on 2020/3/20.
//  Copyright © 2020年 沈海超. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension TargetType {
    var baseURL: URL {
        return URL(string: "https://news.maxjia.com")!
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return nil
    }
}

extension Response {
    func mapJSON(keyPath: String) throws -> Any {
        let json = try self.mapJSON()
        
        if let json = json as? [String: Any], let part = json[keyPath] {
            return part
        }
        throw MoyaError.jsonMapping(self)
    }
}
