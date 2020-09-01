//
//  GitHubApiStream.swift
//  RxSwift_Counter
//
//  Created by Takafumi Ogaito on 2020/08/31.
//  Copyright © 2020 test. All rights reserved.
//

import Unio
import RxSwift
import RxRelay

protocol GitHubApiStreamType: AnyObject {
    var input: InputWrapper<GitHubApiStream.Input> { get }
    var output: OutputWrapper<GitHubApiStream.Output> { get }
}

final class GitHubApiStream: UnioStream<GitHubApiStream>, GitHubApiStreamType {
    
    convenience init(extra: Extra = .init(requestService: .shared)) {
        self.init(input: Input(), state: State(), extra: extra)
    }

    struct Input: InputType {
        let searchText = PublishRelay<String>()
    }

    struct Output: OutputType {
        let searchResponse: Observable<GetRepositoriesResponse>
        let searchError: Observable<Error>
    }
    
    struct Extra: ExtraType {
        let requestService: RequestService
    }

    static func bind(from dependency: Dependency<Input, NoState, Extra>, disposeBag: DisposeBag) -> Output {
        let searchText = dependency.inputObservables.searchText
        let requestService = dependency.extra.requestService
        
        let responseEvent = searchText
            .flatMapLatest { query -> Observable<Event<GetRepositoriesResponse>> in
                return requestService.request(GitHubAPI.GetRepositories(.init(q: query)))
            }
            .share()
        
        return Output(searchResponse: responseEvent.flatMap { $0.element.map(Observable.just) ?? .empty() },
                      searchError: responseEvent.flatMap { $0.error.map(Observable.just) ?? .empty() })
    }
}
