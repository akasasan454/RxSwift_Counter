//
//  Parameterizable.swift
//  RxSwift_Counter
//
//  Created by Takafumi Ogaito on 2020/09/01.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation

protocol Parameterizable: Encodable {
    var json: [String: Any] { get }
    static var encoder: JSONEncoder { get }
}

extension Parameterizable {
    var json: [String: Any] {
        let object = try! JSONSerialization.jsonObject(with: Self.encoder.encode(self), options: .allowFragments)
        return object as! [String: Any]
    }
    
    static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
//        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
}
