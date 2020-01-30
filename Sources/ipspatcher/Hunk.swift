//
//  Hunk.swift
//  ipspatcher
//
//  Created by Grayson Hansard on 1/27/20.
//

public struct Hunk {
    public let offset: Offset
    public let length: UInt16
    public let payload: [UInt8]

    public var isRLE: Bool { return isValidRLEHunk }
    public var RLELength: UInt16 { return UInt16(payload[0]) << 16 + UInt16(payload[1]) }
    public var RLEPayload: UInt8 { return payload[2] }

    public var sizeInBytes: Int {
        return 3 /* offset */ + 2 /* length */ + payload.count
    }

    public static func from(bytes: [UInt8]) -> Hunk? {
        guard bytes.count > 5 else { return nil }

        let offset = Offset(byte1: bytes[0], byte2: bytes[1], byte3: bytes[2])
        let length = UInt16(bytes[3]) << 8 + UInt16(bytes[4])
        let payload = Array(bytes[5..<bytes.count])

        return Hunk(offset: offset, length: length, payload: payload)
    }

    private var isValidRLEHunk: Bool {
        return length == 0 && payload.count == 3
    }
}

extension Hunk {
    public static func from(slice: Slice<UnsafeBufferPointer<UInt8>>) -> Hunk? {
        guard slice.count >= 5 else { return nil }

        let length = 5 + UInt16(slice[slice.startIndex + 3]) << 16 + UInt16(slice[slice.startIndex + 4])
        let payloadLength = length > 0 ? length : 3;
        let bytes = Array<UInt8>(slice[ slice.startIndex ..< slice.startIndex + Int(payloadLength) ])

        return Hunk.from(bytes: bytes)
    }
}
