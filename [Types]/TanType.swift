//
//  TanType.swift
//  TypeKit
//
//  Created by Nicholas Raptis on 5/8/25.
//

import Foundation

@frozen public enum TanType: UInt8 {
    case `in`
    case out
    public func tanTypeOrNone() -> TanTypeOrNone {
        switch self {
        case .in:
            return TanTypeOrNone.in
        case .out:
            return TanTypeOrNone.out
        }
    }
}
