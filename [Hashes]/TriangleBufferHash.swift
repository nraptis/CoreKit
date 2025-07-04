//
//  TriangleBufferHash.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 7/9/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public struct TriangleBufferHash: Equatable {
    
    public init() {
        
    }
    
    public var polyHash = PolyHash()
    var isSelected = false
    var isFrozen = false
    public var isDarkModeEnabled = false
    
    var transformHash = TransformHash()
    public mutating func change(polyHash: PolyHash,
                         isSelected: Bool,
                         isFrozen: Bool,
                         isDarkModeEnabled: Bool,
                         centerX: Float,
                         centerY: Float,
                         scale: Float,
                         rotation: Float) {
        self.polyHash = polyHash
        self.isSelected = isSelected
        self.isFrozen = isFrozen
        self.isDarkModeEnabled = isDarkModeEnabled
        transformHash.change(centerX: centerX,
                             centerY: centerY,
                             scale: scale,
                             rotation: rotation)
    }
    
    public mutating func invalidate() {
        polyHash.invalidate()
    }
}

public struct TriangleBufferWeightsHash: Equatable {
    
    public init() {
        
    }
    
    var polyHash = PolyHash()
    var isSelected = false
    var isFrozen = false
    var isDarkModeEnabled = false
    var transformHash = TransformHash()
    
    var guideOutlineHashes = [OutlineHashGuide]()
    var guideCenterX = Float(-100_000.0)
    var guideCenterY = Float(-100_000.0)
    
    public mutating func change(polyHash: PolyHash,
                         isSelected: Bool,
                         isFrozen: Bool,
                         isDarkModeEnabled: Bool,
                         centerX: Float,
                         centerY: Float,
                         scale: Float,
                         rotation: Float,
                         guideOutlineHashes: [OutlineHashGuide],
                         guideCenterX: Float,
                         guideCenterY: Float) {
        self.polyHash = polyHash
        self.isSelected = isSelected
        self.isFrozen = isFrozen
        self.isDarkModeEnabled = isDarkModeEnabled
        self.guideOutlineHashes = guideOutlineHashes
        self.guideCenterX = guideCenterX
        self.guideCenterY = guideCenterY
        transformHash.change(centerX: centerX,
                             centerY: centerY,
                             scale: scale,
                             rotation: rotation)
    }
    
    public mutating func invalidate() {
        polyHash.invalidate()
    }
}
