//
//  RequestTargetType.swift
//  RxSwift_Counter
//
//  Created by Takafumi Ogaito on 2020/09/01.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import Moya

protocol RequestTargetType: TargetType {
    associatedtype Response: Decodable
    associatedtype Parameter: Parameterizable
    var parameter: Parameter { get set }
    init(_ parameter: Parameter)
}

extension TargetType {
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    var headers: [String : String]? { return nil }
    var sampleData: Data {
        let path = Bundle.main.path(forResource: "samples", ofType: "json")!
        return FileHandle(forReadingAtPath: path)!.readDataToEndOfFile()
    }
}
