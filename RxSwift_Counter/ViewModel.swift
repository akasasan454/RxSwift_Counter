//
//  ViewModel.swift
//  RxSwift_Counter
//
//  Created by Takafumi Ogaito on 2019/01/24.
//  Copyright © 2019 test. All rights reserved.
//

import Unio
import RxSwift
import RxCocoa


protocol ViewStreamType: AnyObject {
    var input: InputWrapper<ViewStream.Input> { get }
    var output: OutputWrapper<ViewStream.Output> { get }
}

final class ViewStream: UnioStream<ViewStream>, ViewStreamType {
    
    convenience init() {
        self.init(input: Input(), state: State(), extra: Extra())
    }

    struct Input: InputType {
        let countUpEvent = PublishRelay<Void>()
        let countDownEvent = PublishRelay<Void>()
        let countResetEvent = PublishRelay<Void>()
    }

    struct Output: OutputType {
        let counterText: Observable<String?>
    }
    
    struct State: StateType {
        let counterValue = BehaviorRelay<Int>(value: 0)
    }
    
    typealias Extra = NoExtra

    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {

        let state = dependency.state
        let input = dependency.inputObservables
        
        let incrementCount = input.countUpEvent
            .withLatestFrom(state.counterValue)
            .map { $0 + 1 }

        let decrementCount = input.countDownEvent
            .withLatestFrom(state.counterValue)
            .map { $0 - 1 }

        let resetCount = input.countResetEvent
            .map { _ in 0 }

        Observable
            .merge(
                incrementCount,
                decrementCount,
                resetCount
            )
            .bind(to: state.counterValue)
            .disposed(by: disposeBag)

        return Output(counterText: state.counterValue.map { "\($0)" })
    }
}
