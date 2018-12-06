//
//  7.数学和错误处理.swift
//  RxSwiftDemo
//
//  Created by YZY on 2018/12/6.
//  Copyright © 2018 ZMJ. All rights reserved.
//

import Foundation
import RxSwift

func toArray() {
    // 把生成的结果压缩到array中
    
    Observable.of(1,2,3).toArray().subscribe { (e) in
        print(e)
    }.disposed(by: bag)
}

func reduce() {
    
    // 遍历迭代
    Observable.of(1,2,3,4).reduce(1, accumulator: +).subscribe(onNext: ({print($0)})).disposed(by: bag)
    
    // 结果是 11
}

func concat() {
    
    /**
     1.使用concat来按顺序合并多个信号为一个信号
     按照合并的顺序来接受数据，先发送的数据先接受到
     但是先发送的必须调用sendCompleted， 否则后发送的数据会接收不到
       */

    
    let subject1 = BehaviorSubject(value: 1)
    
    let subject2 = BehaviorSubject(value: 2)
    
    let variable = Variable(subject1)
    
    variable.asObservable().concat().subscribe{print($0)}.disposed(by: bag)
    
    subject1.onNext(3)
    subject1.onNext(4)
    
    variable.value = subject2
    
    subject2.onNext(5)
    subject2.onNext(6)
    subject1.onNext(7)
    
}

func catchMethod(){
    let subject = PublishSubject<Int>()
    
    // 发生错误后 就停止订阅了  catchErrorJustReturn
    subject.catchErrorJustReturn(1).subscribe { (e) in
        
    }.disposed(by: bag)
    
    subject.onError(NSError(domain: "", code: 1, userInfo: nil))
    
    
    // 发生错误后 就停止当前订阅，转而订阅其他流  catchError
}

func retry() {
    // 发生错误后重试  从头走一遍
    Observable.of(1,2,3).retry().subscribe { (e) in
        
    }.disposed(by: bag)
    
    // 可以加参数 重试几次
    Observable.of(1,2,3).retry(4).subscribe { (e) in
        
        }.disposed(by: bag)
}

func debug() {
    // 测试打印
    
    Observable.of(1,2,3).debug().subscribe { (e) in
        
        }.disposed(by: bag)
    
}


