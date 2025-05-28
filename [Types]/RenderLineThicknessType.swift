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
    
    public func process(start: Float, step: Float) -> Float {
        switch self {
        case .a:
            start + step * Float(0.0)
        case .b:
            start + step * Float(1.0)
        case .c:
            start + step * Float(2.0)
        case .d:
            start + step * Float(3.0)
        }
    }
    
}

