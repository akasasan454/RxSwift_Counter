//
//  ViewStream.swift
//  RxSwift_Counter
//
//  Created by Takafumi Ogaito on 2019/01/24.
//  Copyright © 2019 test. All rights reserved.
//

import Unio
import RxSwift
import RxCocoa
import RxSwiftExt

protocol ViewStreamType: AnyObject {
    var input: InputWrapper<ViewStream.Input> { get }
    var output: OutputWrapper<ViewStream.Output> { get }
}

final class ViewStream: UnioStream<ViewStream>, ViewStreamType {
    
    convenience init(extra: Extra = .init(apiStream: GitHubApiStream())) {
        self.init(input: Input(), state: State(), extra: extra)
    }

    struct Input: InputType {
        let searchText = PublishRelay<String>()
    }

    struct Output: OutputType {
        let counterText: Observable<String>
    }
    
    struct Extra: ExtraType {
        let apiStream: GitHubApiStreamType
    }

    static func bind(from dependency: Dependency<Input, NoState, Extra>, disposeBag: DisposeBag) -> Output {
        let input = dependency.inputObservables
        let apiStream = dependency.extra.apiStream
        
        input.searchText
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(to: apiStream.input.searchText)
            .disposed(by: disposeBag)
        
        let text = Observable
            .merge(
                apiStream.output.searchResponse.map { $0.items.first?.fullName },
                apiStream.output.searchError.map { $0.localizedDescription }
            )
            .unwrap()
            .distinctUntilChanged()
            .share()

        return Output(counterText: text)
    }
}
