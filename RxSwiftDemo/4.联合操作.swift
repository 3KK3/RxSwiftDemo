
//
//  4.操作.swift
//  RxSwiftDemo
//
//  Created by YZY on 2018/12/6.
//  Copyright © 2018 ZMJ. All rights reserved.
//

import Foundation
import RxSwift


func startWith() {
    
    Observable.of(1,2,3).startWith(0).subscribe { (event) in
        print(event)
    }.disposed(by: bag)
    
    // 输出是0 1 2 3， 0会插入到前面
}

func merge() {
    // 将两个流按照时间线合并
    /**
     ------1----3--------6---
     ---------2------5------
     merge后的结果是 -1--2-3-5---6-
     */
    
    let subject1 = PublishSubject<String>()
    let subject2 = PublishSubject<String>()
    
    Observable.of(subject1, subject2).merge().subscribe {(event) in
        
    }.disposed(by: bag)
    
    subject1.onNext("1")
    subject2.onNext("2")
    subject1.onNext("3")
}

func zip() {
    // 区别于merge， zip会按照时间线 将最近的两个数据组合成一组
    /**
     ------1----3-------------6---
     ---------2------4---5-----
     zip后的结果是 ---(1,2)--(3,4)--(6,5)--
     */
    
    let subject1 = PublishSubject<String>()
    let subject2 = PublishSubject<String>()
    
    Observable.zip(subject2, subject1) { e1, e2 in "\(e1) \(e2)" }.subscribe(onNext:{print($0)}).disposed(by: bag)
    
    subject1.onNext("1")
    subject2.onNext("2")
    subject1.onNext("3")
}

func combineLatest() {
    
    /**
     ------1----3-------------6---
     ---------2------4---5-----
     zip后的结果是 ---(1,2)--(3,2)--(3，4)--(3，5)-----（6，5）---
     */
    
    let subject1 = PublishSubject<String>()
    let subject2 = PublishSubject<String>()
    
    Observable.combineLatest(subject2, subject1) { e1, e2 in "\(e1) \(e2)" }.subscribe(onNext:{print($0)}).disposed(by: bag)
    
    subject1.onNext("1")
    subject2.onNext("2")
    subject1.onNext("3")
}

func switchLatest() {
    
    let subject1 = BehaviorSubject(value: 1)
    let subject2 = BehaviorSubject(value: 2)
    
    let variabel = Variable(subject1)
    
    variabel.asObservable().switchLatest().subscribe { (event) in
        print(event)
    }.disposed(by: bag)
    
    subject1.onNext(3)
    subject1.onNext(5)
    
    variabel.value = subject2
    
    subject1.onNext(6)
    subject2.onNext(7)
}
