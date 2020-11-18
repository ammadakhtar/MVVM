//
//  whitespectre_ios_challengeTests.swift
//  whitespectre-ios-challengeTests
//
//  Created by Mac on 5/30/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import XCTest
@testable import whitespectre_ios_challenge

class whitespectre_ios_challengeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Initialization Tests
    
    func testInit_GifModel() {
        let testGif = Gif(title: "A unit test gif", id: "12345678", url: "https://somedummyurl.com")
        XCTAssertNotNil(testGif)
        XCTAssertEqual(testGif.title, "A unit test gif")
        XCTAssertEqual(testGif.id, "12345678")
        XCTAssertEqual(testGif.gifUrl, "https://somedummyurl.com")
    }
    
    // MARK: - Equatable Tests
    
    func testEquatable_ReturnsTrue() {
        let testGif1 = Gif(title: "A unit test gif", id: "12345678", url: "https://somedummyurl.com")
        let testGif2 = Gif(title: "A unit test gif", id: "12345678", url: "https://somedummyurl.com")

        XCTAssertEqual(testGif1, testGif2)
    }

}
