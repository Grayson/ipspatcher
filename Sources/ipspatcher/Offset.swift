//
//  Offset.swift
//  ipspatcher
//
//  Created by Grayson Hansard on 1/27/20.
//

import Foundation

public struct Offset {
    let byte1: UInt8
    let byte2: UInt8
    let byte3: UInt8

    var value: UInt32 {
        return UInt32(byte1) << 16 | UInt32(byte2) << 8 | UInt32(byte3)
    }
}
