//
//  Tests_macOS.swift
//  Tests macOS
//
//  Created by Michael Cardiff on 2/16/22.
//

import XCTest
//import Overlap_Integrals

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
    
    // test that monte carlo should do approximately the right thing
    func test1sIntegral() async throws {
        let monteCarlo = MonteCarloCalculator()
        await monteCarlo.monteCarloIntegrate(leftwavefunction: psi1s, rightwavefunction: psi1s, xMin: 0, yMin: 0, zMin: 0, xMax: 1, yMax: 1, zMax: 1, n: 100000, spacing: 0)
        
        XCTAssertEqual(0.05490967852103143, monteCarlo.integral, accuracy: 0.001, "expected better from you")
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
