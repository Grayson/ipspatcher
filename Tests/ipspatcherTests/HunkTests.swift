//
//  HunkTests.swift
//  ipspatcherTests
//
//  Created by Grayson Hansard on 1/27/20.
//

import Foundation
import XCTest
@testable import ipspatcher

final class HunkTests: XCTestCase {
    func testStandardHunk() {
        let bytes: [UInt8] = [
            0x01, 0x02, 0x03, /* Offset */
            0x00, 0x01, /* Length */
            0xFF /* Payload */
        ]
        let hunk = Hunk.from(bytes: bytes)!
        XCTAssertEqual(0x010203, hunk.offset.value)
        XCTAssertEqual(0x0001, hunk.length)
        XCTAssertEqual([0xFF], hunk.payload)
    }

    func testRLEHunk() {
        let bytes: [UInt8] = [
            0x01, 0x02, 0x03, /* Offset */
            0x00, 0x00, /* Length */
            0x00, 0x02, /* RLE repeat */
            0xFF /* Payload */
        ]
        let hunk = Hunk.from(bytes: bytes)!
        XCTAssertTrue(hunk.isRLE)
        XCTAssertEqual(0x0002, hunk.RLELength)
        XCTAssertEqual(0xFF, hunk.RLEPayload)
    }
}
