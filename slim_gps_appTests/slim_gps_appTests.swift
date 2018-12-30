//
//  slim_gps_appTests.swift
//  slim_gps_appTests
//
//  Created by 福原佑介 on 2018/06/23.
//  Copyright © 2018年 yusuke. All rights reserved.
//

//import XCTest
//
//class slim_gps_appTests: XCTestCase {
//
//    override func setUp() {
//        super.setUp()
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
//
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}

import Foundation
import Quick
import Nimble
import Hydra
//@testable import QuickSample
@testable import slim_gps_app

class GiocatoreSpec: QuickSpec {
    override func spec() {
        describe("サッカー選手") {
            it("名前") {
                let interactor = UserInfoInteractor()
                let name = "Inzaghi"
                expect("My name is \(name)").to(equal("My name is \(name)"))
            }
        }
    }
}
