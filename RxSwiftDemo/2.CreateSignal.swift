
//
//  CreateSignal.swift
//  RxSwiftDemo
//
//  Created by YZY on 2018/12/6.
//  Copyright © 2018 ZMJ. All rights reserved.
//

import Foundation
import RxSwift

let bag = DisposeBag()

func create() {
    
    Observable<String>.create { (observer) -> Disposable in
        observer.onNext("123")
        observer.onCompleted()
        return Disposables.create()
        }
        .subscribe { (_) in
            
        }
        .disposed(by: bag)
    
    
    // 另一种写法
    let createClosure = { (element: String) -> Observable<String> in
        return  Observable<String>.create { (observer) -> Disposable in
            observer.onNext("123")
            observer.onCompleted()
            return Disposables.create()
        }
    }
    createClosure("123").subscribe().disposed(by: bag)
}

func range() {
    
    //range(n, n+m)  范围
}

func repeatElement() {
    
    // repeatElement一直重复
    // take 取前几次
    Observable.repeatElement(3).take(1).subscribe().disposed(by: bag)
}


func generate() {
    
    // 创建一个可观察的sequence，当初始化的条件为true的时候，他就会发出对应的事件
    Observable.generate(initialState: 0, condition: {$0 < 3}, iterate: {$0 + 1}).subscribe().disposed(by: bag)
    
}

func defered() {
    
    // 直到有观察者订阅才创建oberveable，并且为每个观察者创建一个新的observable
    var index = 0
    let deferedSequence = Observable<String>.deferred {
        index += 1
        print(index)
        
        return Observable.create({ observer -> Disposable in
            observer.onNext("123")
            observer.onCompleted()
            return Disposables.create()
        })
    }
    
    // 两次订阅 其实是走了两边创建 打印出来的内容不一样
    deferedSequence.subscribe(onNext:{print($0)}).disposed(by: bag)
    deferedSequence.subscribe(onNext:{print($0)}).disposed(by: bag)
}


func doOnOrCompletion(){
    // doOn 调用发生在onNext前
    // doCompletion 调用发生在onCompleted前面
    
}
