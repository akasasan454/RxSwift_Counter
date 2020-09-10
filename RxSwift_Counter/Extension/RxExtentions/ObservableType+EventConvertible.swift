//
//  ObservableType+EventConvertible.swift
//  RxSwift_Counter
//
//  Created by Takafumi Ogaito on 2020/09/01.
//  Copyright © 2020 test. All rights reserved.
//

import RxSwift

extension ObservableType where Element: EventConvertible {
    public func elements() -> Observable<Element.Element> {
        return compactMap { $0.event.element }
    }

    public func errors() -> Observable<Swift.Error> {
        return compactMap { $0.event.error }
    }
}
