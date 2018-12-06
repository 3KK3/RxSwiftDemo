//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by YZY on 2018/12/6.
//  Copyright © 2018 ZMJ. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class ViewController: UIViewController {
    
    @IBOutlet weak var getTimeBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    
    var viewModel: ViewModel!
    
    @IBAction func getTimeAction(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setUpUI()
//        setUpUI1()

        setUpUI2()
        
        
//        combineLatest()
//        map()
//        scan()
//        filter()
//        single()
//        take()
//        takeUntil()
//        skip()
        
//        reduce()
        concat()
        
    }
    
    func setUpUI() {
        
        // ----------------------------✨--------------------------

        // 订阅btn 点击事件
        
//        getTimeBtn.rx.tap.subscribe ({
//            [weak self] _ in
//            self?.timeLabel.text = "123"
//
//        }).disposed(by: bag)
        
        
        // ----------------------------✨--------------------------
        
        
        // 绑定信号
//        getTimeBtn.rx.tap.map({
//            _ in
//            return "123456"
//
//        }).bind(to: timeLabel.rx.text).disposed(by: bag)
        
        
        // -----------------------------✨-------------------------
        
        // 使用share 保证只执行一次
        
        func mapF() -> String {
            print(1111111)
            return "12344"
        }

//        let signal = getTimeBtn.rx.tap.map(mapF).share(replay: 1)
//
//        signal.bind(to: timeLabel.rx.text).disposed(by: bag)
//        signal.bind(to: topLabel.rx.text).disposed(by: bag)
        
        // -------------------------✨-------------------------
        /*
         * drive : 1.不能出错 2。观察主线程 3.共享资源
         */
        
        let signal = getTimeBtn.rx.tap.asDriver().map(mapF)
        
        signal.drive(timeLabel.rx.text).disposed(by: bag)
        signal.drive(topLabel.rx.text).disposed(by: bag)
    }
    
    
    func setUpUI1() {
        viewModel = ViewModel()
        let input = ViewModel.input(refreshTap: self.getTimeBtn.rx.tap.asDriver())
        let output = self.viewModel.transform(input: input)
        output.currentTime.drive(self.timeLabel.rx.text).disposed(by: bag)
    }
    
    func setUpUI2() {
        viewModel = ViewModel()
        let input = ViewModel.input(refreshTap: self.getTimeBtn.rx.tap.asDriver())
        let output = self.viewModel.getServiceTime(input: input)
        output.currentTime.drive(self.timeLabel.rx.text).disposed(by: bag)
    }
}

