//
//  RequestService.swift
//  RxSwift_Counter
//
//  Created by Takafumi Ogaito on 2020/08/31.
//  Copyright © 2020 test. All rights reserved.
//

import Moya
import RxSwift

final class RequestService {
    static let shared = RequestService()
    private let provider = MoyaProvider<MultiTarget>()
    
    func request<R>(_ request: R) -> Observable<Event<R.Response>> where R: RequestTargetType {
        let target = MultiTarget(request)
        return provider.rx.request(target)
            .filterSuccessfulStatusCodes()
            .map(R.Response.self, using: decoder)
            .asObservable()
            .materialize()
    }

    func requestString<R>(_ request: R) -> Observable<Event<String>> where R: TargetType {
        let target = MultiTarget(request)
        return provider.rx.request(target)
            .filterSuccessfulStatusCodes()
            .mapString()
            .asObservable()
            .materialize()
    }

    func requestJson<R>(_ request: R) -> Observable<Event<Any>> where R: TargetType {
        let target = MultiTarget(request)
        return provider.rx.request(target)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .materialize()
    }
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
