//
//  GetRepositories.swift
//  RxSwift_Counter
//
//  Created by Takafumi Ogaito on 2020/09/01.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import Moya

extension GitHubAPI {
    struct GetRepositories: RequestTargetType {
        typealias Response = GetRepositoriesResponse
        typealias Parameter = GetRepositoriesParameter
        
        var parameter: Parameter
        var method: Moya.Method { return .get }
        var path: String { return "/search/repositories" }
        var task: Task {
            return .requestParameters(parameters: parameter.json, encoding: URLEncoding.default)
        }

        init(_ parameter: Parameter) {
            self.parameter = parameter
        }
    }
}

struct GetRepositoriesResponse : Decodable {
    let items: [Repository]
}

struct Repository: Decodable, Equatable {
    let name: String
    let fullName: String
    let htmlUrl: URL
}
