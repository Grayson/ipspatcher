//
//  Offset.swift
//  ipspatcher
//
//  Created by Grayson Hansard on 1/27/20.
//

import Foundation

public struct Offset {
    public let byte1: UInt8
    public let byte2: UInt8
    public let byte3: UInt8

    public var value: UInt32 {
        return UInt32(byte1) << 16 | UInt32(byte2) << 8 | UInt32(byte3)
    }
}
