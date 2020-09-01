//
//  ViewController.swift
//  RxSwift_Counter
//
//  Created by Takafumi Ogaito on 2019/01/24.
//  Copyright © 2019 test. All rights reserved.
//

import Unio
import RxSwift
import RxCocoa
import RxSwiftExt

class ViewController: UIViewController {

    @IBOutlet weak var field: UITextField!
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
        
        field.rx.text
            .unwrap()
            .bind(to: input.searchText)
            .disposed(by: disposeBag)
        
        let output = viewStream.output
        output.counterText
            .asDriver(onErrorDriveWith: .never())
            .drive(countLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
