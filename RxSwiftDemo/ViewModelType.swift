

//
//  ViewModelType.swift
//  RxSwiftDemo
//
//  Created by YZY on 2018/12/6.
//  Copyright © 2018 ZMJ. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype input
    associatedtype output
    
    func transform(input: input) -> output
}
