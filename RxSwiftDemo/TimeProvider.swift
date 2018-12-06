
//
//  TimeProvider.swift
//  RxSwiftDemo
//
//  Created by YZY on 2018/12/6.
//  Copyright © 2018 ZMJ. All rights reserved.
//

import Foundation
import RxAlamofire
import RxCocoa
import RxSwift

class TimerProvider {
    
    let url = "https://www.baidu.com"
    var input: Observable<Void>
    lazy var rx_currentTime = self.getTime()
    
    init(withInput input: Observable<Void>) {
        self.input = input
    }
    
    fileprivate func getTime() -> Driver<String> {
        
        return input
            .do(onNext: {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            })
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background)) // 后续操作在后台线程
            .flatMapLatest{ _ in
                return RxAlamofire.requestJSON(.get, self.url).debug()
            }
            .map{ (response, json) ->  String in
                if json is [String: AnyObject] {
                    return "have data"
                    
                } else {
                    return "no data"
                }
            }
            .do(onNext: { _ in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
            .asDriver(onErrorJustReturn: "error 123")
    }
}

