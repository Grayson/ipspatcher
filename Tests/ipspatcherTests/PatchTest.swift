//
//  File.swift
//  ipspatcherTests
//
//  Created by Grayson Hansard on 1/29/20.
//

import XCTest
@testable import ipspatcher

final class PatchTests: XCTestCase {
    public func testPatchCreation() {
        let bytes: [UInt8] = [
            0x50, 0x41, 0x54, 0x43, 0x48, // PATCH
            0x01, 0x02, 0x03, /* offset */ 0x00, 0x02, /* length */ 0xFE, 0xFF, /* payload */ /* Hunk */
            0x45, 0x4f, 0x46 // EOF
        ]

        bytes.withUnsafeBufferPointer { pointer in
            let patch = Patch.from(pointer: pointer.baseAddress!, length: pointer.count)
            XCTAssertNotNil(patch)
            XCTAssertEqual(patch?.hunks.count, 1)
            XCTAssertEqual(patch?.hunks[0].sizeInBytes, 7)
        }
    }
}
