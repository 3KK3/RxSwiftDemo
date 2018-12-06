
//
//  Demo.swift
//  RxSwiftDemo
//
//  Created by YZY on 2018/12/6.
//  Copyright © 2018 ZMJ. All rights reserved.
//

import Foundation
import RxSwift

let disposeBag = DisposeBag()

func createNeverEvent() {
    
    /// never 创建永不发射 永不停止的可观察对象
    Observable<String>
        .never()
        .subscribe { (_) in
            print("此条永远不会打印")
        }
        .disposed(by: disposeBag)
}

func createEmptyEvent() {
    
    /// empty 创建不发射任何数据，可以正常终止的可观察对象
    Observable<String>
        .empty()
        .subscribe { (_) in
            
        }
        .disposed(by: disposeBag)
}

func createErrorEvent() {
    
    /// 创建一个可观察的序列，但不发出任何正常的事件，只发出error事件并结束
    let error = NSError(domain: "COM.BAIDU.CN", code: 0, userInfo: [NSLocalizedDescriptionKey : ""])
    Observable<Int>
        .error(error)
        .subscribe {
            print($0)
        }
        .disposed(by: disposeBag)
}

func createJustEvent() {
    
    /// 创建一个发射指定值的Observable
    Observable.just("abc").subscribe().disposed(by: disposeBag)
}

func createOfEvent() {
    
    /// 创建一个能发出多种事件的信号
    Observable.of(1,2).subscribe().disposed(by: disposeBag)
}

func createFromEvent() {
    
    /// 跟of的b区别是 from是一个数组
    Observable<Int>.from([1,2,3]).subscribe().disposed(by: disposeBag)
}
