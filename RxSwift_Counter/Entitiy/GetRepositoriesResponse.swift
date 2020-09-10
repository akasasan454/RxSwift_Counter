//
//  GetRepositoriesResponse.swift
//  RxSwift_Counter
//
//  Created by Takafumi Ogaito on 2020/09/01.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation

struct GetRepositoriesResponse : Decodable {
    let items: [Repository]
}
