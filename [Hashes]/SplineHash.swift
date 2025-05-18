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
    
    public init() {
        
    }
    
    public var value: Int = -1
    public mutating func change() {
        value += 1
        if value >= 100_000 {
            value = 0
        }
    }
}
