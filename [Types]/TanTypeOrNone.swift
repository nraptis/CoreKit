//
//  TanTypeOrNone.swift
//  TypeKit
//
//  Created by Nicholas Raptis on 5/8/25.
//

import Foundation

@frozen public enum TanTypeOrNone: UInt8 {
    case none
    case `in`
    case out
    
    public var isTan: Bool {
        switch self {
        case .none:
            return false
        case .in:
            return true
        case .out:
            return true
        }
    }
    
    public var tanType: TanType? {
        switch self {
        case .none:
            return nil
        case .in:
            return TanType.in
        case .out:
            return TanType.out
        }
    }
    
}



