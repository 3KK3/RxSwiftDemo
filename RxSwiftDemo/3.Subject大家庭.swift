//
//  Subject大家庭.swift
//  RxSwiftDemo
//
//  Created by YZY on 2018/12/6.
//  Copyright © 2018 ZMJ. All rights reserved.
//

import Foundation
import RxSwift

func createPublishSubject() {
    
    // 当订阅publishSubject后，只能收到订阅开始 以后的事件，订阅前的收不到
    
    let subjectString = PublishSubject<String>()
    subjectString.asObserver().disposed(by: bag)
    subjectString.onNext("123")
    _ = subjectString.subscribe { (event) in
        print(event)
    }
}

func replySubject() {
    
    // 往前追溯10个内容 可以保存订阅前的数据
    let replayString = ReplaySubject<String>.create(bufferSize: 10)
    
    replayString.asObserver().disposed(by: bag)
    replayString.onNext("123")
    _ = replayString.subscribe { (event) in
        
    }
}
func behaviourSubject() {
    // 拿到最近的一个值，如果最近没有值，则拿到默认值
    
    let subject = BehaviorSubject(value: "123")
    subject.asObserver().disposed(by: bag)
    subject.onNext("1")
    
}

func variable() {
    /// 包装behaviorSubject 所以他会发出最新的值 或者 初始值，variable还保持值状态，且不会发出一个错误事件
    
    let variabel = Variable("234")
    variabel.value = "1"
    variabel.value = "2"
    variabel.asObservable().subscribe { (event) in
        print(event)
    }
    .disposed(by: bag)
}



