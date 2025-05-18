//
//  AffineHash.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 7/8/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public struct TransformHash: Equatable {
    
    public init() {
        
    }
    
    var centerX = Float(-100_000.0)
    var centerY = Float(-100_000.0)
    var scale = Float(-100_000.0)
    var rotation = Float(-100_000.0)
    public mutating func change(centerX: Float,
                         centerY: Float,
                         scale: Float,
                         rotation: Float) {
        self.centerX = centerX
        self.centerY = centerY
        self.scale = scale
        self.rotation = rotation
    }
}

public struct TransformHashExtended: Equatable {
    
    public init() {
        
    }
    
    var centerX = Float(-100_000.0)
    var centerY = Float(-100_000.0)
    var scale = Float(-100_000.0)
    var rotation = Float(-100_000.0)
    var worldScale = Float(-100_000.0)
    public mutating func change(centerX: Float,
                         centerY: Float,
                         scale: Float,
                         rotation: Float,
                         worldScale: Float) {
        self.centerX = centerX
        self.centerY = centerY
        self.scale = scale
        self.rotation = rotation
        self.worldScale = worldScale
    }
}
