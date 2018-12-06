//
//  6.过滤和约束.swift
//  RxSwiftDemo
//
//  Created by YZY on 2018/12/6.
//  Copyright © 2018 ZMJ. All rights reserved.
//

import Foundation
import RxSwift

func filter() {
    // 添加过滤条件
    Observable
        .of(1,2,3,4,5)
        .filter { (element) -> Bool in
            return 3 > element
        }.subscribe(onNext:{print($0)}).disposed(by: bag)
}


func distinctUntiChanged() {
    // 跟上次作比对 去重
    Observable.of(1,2,1,1,2,3).distinctUntilChanged().subscribe(onNext: {print($0)}).disposed(by: bag)
    // 打印结果 1 2 1 2 3
}

func elementAt() {
    
    // 指定第几个  下面是5  从0开始计算 所以是第六个数据
    Observable.of(1,2,3,4,5,6).elementAt(3).subscribe(onNext: ({print($0)})).disposed(by: bag)
}

func single() {
    // 用法1  确保只发出一次信号 如果多次就会报错 比如.of(1,2,3)
    Observable.of(10).single().subscribe(onNext: ({print($0)})).disposed(by: bag)
    
    // 用法2 single接判断条件确保只有一次结果
    Observable.of(1,2,3).single({$0 == 1}).subscribe(onNext: ({print($0)})).disposed(by: bag)

}

func take() {
    // 去前几次结果
    Observable.of(1,2,3).take(1).subscribe(onNext: ({print($0)})).disposed(by: bag)
    
}

func takeLast() {
    // 从后往前数
    Observable.of(1,2,3).takeLast(1).subscribe(onNext: ({print($0)})).disposed(by: bag)
}


func takeWhile() {
    
    // 一直拿 直到指定条件满足就停止
    
    Observable.of(1,2,3,5,6,7).takeWhile({$0 < 5}).subscribe(onNext: ({print($0)})).disposed(by: bag)

    // 打印结果 1 ，2 , 3
}

func takeUntil() {
    
    // 一直取 直到给定信号发生就停止
    
    let subject1 = PublishSubject<Int>()
    
    let subject2 = PublishSubject<Int>()
    
    subject2.takeUntil(subject1).subscribe(onNext: ({print($0)})).disposed(by: bag)
    
    subject2.onNext(1)
    subject1.onNext(2)
    subject2.onNext(3)
    
    // 打印结果 1
}

func skip() {
    
    // 跳过前n个
    Observable.of(1,2,3).skip(2).subscribe(onNext: ({print($0)})).disposed(by: bag)
    
    // 打印结果 3
}


func skipWhile() {
    
    // 一直skip直到条件满足 再取值
    Observable.of(1,2,3,4).skipWhile({$0 > 3}).subscribe(onNext: ({print($0)})).disposed(by: bag)
    
    // 打印结果 4
}

// 弃用

//func skipWhileWithIndex() {
//
//    // 一直skip直到条件满足 再取值
//    Observable.of(1,2,3,4).skipWhile({$0 > 3}).subscribe(onNext: ({print($0)})).disposed(by: bag)
//
//    // 打印结果 4
//}


func skipUntil() {
    
    // 一直skip直到另一信号发生  类比takeUntil
}
