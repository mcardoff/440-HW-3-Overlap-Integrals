//
//  Tests_macOS.swift
//  Tests macOS
//
//  Created by Jeff_Terry on 2/23/22.
//

import XCTest

class Tests_macOS: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    // test that the func returns the right value
    func test1s() throws {
        //spherical symmetry
        var testval = psi1s(x: 1, y: 0, z: 0)
        var ans = 0.2075537487102974
        XCTAssertEqual(testval, ans, accuracy: 1e-10, "You didnt do good enough")
        
        testval = psi1s(x: 0, y: 1, z: 0)
        XCTAssertEqual(testval, ans, accuracy: 1e-10, "You didnt do good enough")
        
        testval = psi1s(x: 0, y: 0, z: 1)
        XCTAssertEqual(testval, ans, accuracy: 1e-10, "You didnt do good enough")
        
        testval = psi1s(x: 1.0/sqrt(3), y: 1.0/sqrt(3), z: 1.0/sqrt(3))
        XCTAssertEqual(testval, ans, accuracy: 1e-10, "You didnt do good enough")
        
        // Value at origin
        testval = psi1s(x: 0, y: 0, z: 0)
        ans = 1 / sqrt(Double.pi)
        XCTAssertEqual(testval, ans, accuracy: 1e-10, "You didnt do good enough")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
