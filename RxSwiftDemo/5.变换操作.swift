//
//  5.变换操作.swift
//  RxSwiftDemo
//
//  Created by YZY on 2018/12/6.
//  Copyright © 2018 ZMJ. All rights reserved.
//

import Foundation
import RxSwift

func map(){
    
    Observable.of(1,3,4).map({$0 * $0}).subscribe(onNext: ({print($0)})).disposed(by: bag)
}

func flatMap() {
    
    
    
}

func flatMapLatest() {
    
    
    
}

func scan() {
    // 迭代
    
    /**
     -----1---2-----3---
     scan((x,y) ---> x+ y)
     -----4-----5---
          ⬇️
     -----5-----5---
     */
    
    // 指定的初始值是1
    Observable.of(10,100,1000).scan(1) { seed, newValue in seed + newValue}.subscribe(onNext: {print($0)}).disposed(by: bag)
    // 1 + 10
    //  + 100
    // + 1000
}


