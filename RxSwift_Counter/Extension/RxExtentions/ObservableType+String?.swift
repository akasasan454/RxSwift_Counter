//
//  ObservableType+String?.swift
//  RxSwift_Counter
//
//  Created by Takafumi Ogaito on 2020/09/01.
//  Copyright © 2020 test. All rights reserved.
//

import RxSwift

extension ObservableType where Element == String? {
    func filterEmpty() -> Observable<String> {
        return filter { $0?.isEmpty != true }.map { $0! }
    }
}
