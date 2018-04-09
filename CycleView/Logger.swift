//
//  Logger.swift
//  CycleView
//
//  Created by hezhiqiang on 2018/4/10.
//  Copyright © 2018年 Totorotec. All rights reserved.
//

import Foundation

func ZYLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent):[第\(line)行], \(method): \n \(message)")
    #endif
}
