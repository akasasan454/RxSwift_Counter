//
//  ViewModel.swift
//  RxSwift_Counter
//
//  Created by Takafumi Ogaito on 2019/01/24.
//  Copyright © 2019 test. All rights reserved.
//

import RxSwift
import RxCocoa

struct ViewModelInput {
    let countUpButton: Observable<Void>
    let countDownButton: Observable<Void>
    let countResetButton: Observable<Void>
}

protocol ViewModelOutput {
    var counterText: Driver<String?> { get }
}

protocol ViewModelType {
    var outputs: ViewModelOutput? { get }
    func setUp(input: ViewModelInput)
}

class RxViewModel: ViewModelType {
    var outputs: ViewModelOutput?
    
    
    private let relay = BehaviorRelay<Int>(value: 0)
    private let initialCount = 0
    private let disposeBag = DisposeBag()
    
    init() {
        self.outputs = self
        resetCount()
    }
    
    func setUp(input: ViewModelInput) {
        input.countUpButton.subscribe(onNext: { [weak self] in
            <#code#>
        }
    }
}

extension RxViewModel: ViewModelOutput {
    var counterText: Driver<String?> {
        return relay
            .map { "\($0)" }
            .asDriver(onErrorJustReturn: nil)
    }
    
    
}
