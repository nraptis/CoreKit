//
//  RenderLineThicknessType.swift
//  TypeKit
//
//  Created by Nicholas Raptis on 5/9/25.
//

import Foundation

@frozen public enum RenderLineThicknessType: UInt8 {
    case a
    case b
    case c
    case d
    
    public func process(start: Int, step: Int) -> Int {
        switch self {
        case .a:
            start + step * 0
        case .b:
            start + step * 1
        case .c:
            start + step * 2
        case .d:
            start + step * 3
        }
    }
    
}

