//
//  Repository.swift
//  RxSwift_Counter
//
//  Created by Takafumi Ogaito on 2020/09/01.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation


struct Repository: Decodable, Equatable {
    let name: String
    let fullName: String
    let htmlUrl: URL
}
