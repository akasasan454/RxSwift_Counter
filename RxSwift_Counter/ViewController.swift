//
//  ViewController.swift
//  RxSwift_Counter
//
//  Created by Takafumi Ogaito on 2019/01/24.
//  Copyright © 2019 test. All rights reserved.
//

import Unio
import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countUpButton: UIButton!
    @IBOutlet weak var countDownButton: UIButton!
    @IBOutlet weak var countResetButton: UIButton!
    
    private let viewStream = ViewStream()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        let input = viewStream.input
        countUpButton.rx.tap
            .bind(to: input.countUpEvent)
            .disposed(by: disposeBag)
        
        countDownButton.rx.tap
            .bind(to: input.countDownEvent)
            .disposed(by: disposeBag)
        
        countResetButton.rx.tap
            .bind(to: input.countResetEvent)
            .disposed(by: disposeBag)
        
        let output = viewStream.output
        output.counterText
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
