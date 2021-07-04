//
//  AirProximityTests.swift
//  AirProximityTests
//
//  Created by Shaunak Jagtap on 05/07/21.
//

import XCTest
@testable import AirProximity

class AirProximityTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testServerConnection() throws {
        let aqiVM = AirQualityViewModel()
        aqiVM.listenAQIEvents()
        let aqiExpectation = expectation(description: "connected")
        aqiVM.aqiCallback = {
            aqiExpectation.fulfill()
        }
        waitForExpectations(timeout: 3)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
