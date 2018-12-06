
//
//  ViewModel.swift
//  RxSwiftDemo
//
//  Created by YZY on 2018/12/6.
//  Copyright © 2018 ZMJ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewModel: ViewModelType {
    
    func transform(input: input) -> output {
        
        let currentTime = input.refreshTap.map({return "view model data"})
        return output(currentTime: currentTime)
    }
    
    func getServiceTime(input: input) -> output {
        
        let currentTime = TimerProvider(withInput: input.refreshTap.asObservable()).rx_currentTime
        return output(currentTime: currentTime)
    }
}

extension ViewModel {
    struct input {
        let refreshTap: Driver<Void>
    }
    
    struct output {
        let currentTime: Driver<String>
        
    }
    
}
