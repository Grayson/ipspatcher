//
//  OffsetTests.swift
//  ips_patcherTests
//
//  Created by Grayson Hansard on 1/27/20.
//

import XCTest
@testable import ipspatcher

final class OffsetTests: XCTestCase {
    func testValue() {
        let offset = Offset(byte1: 0x01, byte2: 0x02, byte3: 0x03)
        XCTAssertEqual(0x010203, offset.value)
    }

    static var allTests = [
        ("testValue", testValue),
    ]
}
