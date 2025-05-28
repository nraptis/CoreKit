//
//  JiggleSplineHash.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 7/8/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public struct SplineHash: Equatable {
    
    nonisolated(unsafe) static var invalid_index = -2
    
    public init() {
        
    }
    
    public var value: Int = -1
    public mutating func change() {
        value += 1
        if value >= 100_000 {
            value = 0
        }
    }
    
    public mutating func invalidate() {
        value = SplineHash.invalid_index
        SplineHash.invalid_index -= 1
        if SplineHash.invalid_index < -100_000 {
            SplineHash.invalid_index = -2
        }
    }
    
}
