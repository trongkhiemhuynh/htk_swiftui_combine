//
//  TestSwift.swift
//  HTKLoanCalculator
//
//  Created by LDCC Macbook Pro on 25/08/2023.
//

import Foundation

struct TestStruct: AnotherProtocol, SomeProtocol {
    static var someTypeProperty: Int = 0
    
    func doSomethingElse() {
//        var string: NSString = "declare nsstring type"
//        let _string: String = "hello string"
//        string = _string
        TestStruct.someTypeProperty = 1
    }
    
    var mustBeSettable: Int
    var doesNotNeedToBeSettable: Int
}

///take a while

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}
