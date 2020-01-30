//
//  Patch.swift
//  ipspatcher
//
//  Created by Grayson Hansard on 1/27/20.
//

import Foundation

public struct Patch {
    public static let header = "PATCH"
    public static let footer = "EOF"

    public let hunks: [Hunk]

    public static func from(pointer: UnsafePointer<UInt8>, length: Int) -> Patch? {
        guard length > (Patch.header.count + Patch.footer.count) else { return nil }

        let buffer = UnsafeBufferPointer(start: pointer, count: length)
        let header = buffer[0 ..< Patch.header.count].reduce("") { "\($0)\(Character(Unicode.Scalar($1)))" }
        guard header == Patch.header else {
            print("header: \(header)")
            return nil }

        var offset = Patch.header.count
        var hunks: [Hunk] = []
        while true {
            let slice = buffer[offset ..< length]
            guard let hunk = Hunk.from(slice: slice) else { break }
            hunks.append(hunk)
            offset += hunk.sizeInBytes
        }

        return Patch(hunks: hunks)
    }
}
