//
//  OutlineHash.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 7/8/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public struct OutlineHash: Equatable {
    
    public init() {
        
    }
    
    var splineHash = SplineHash()
    var transformHash = TransformHash()
    var lineThicknessType = RenderLineThicknessType.a
    
    public mutating func change(splineHash: SplineHash,
                         centerX: Float,
                         centerY: Float,
                         scale: Float,
                         rotation: Float,
                         lineThicknessType: RenderLineThicknessType) {
        
        transformHash.change(centerX: centerX,
                             centerY: centerY,
                             scale: scale,
                             rotation: rotation)
        self.splineHash = splineHash
        self.lineThicknessType = lineThicknessType
    }
}

public struct OutlineHashExtended: Equatable {
    
    public init() {
        
    }
    
    var splineHash = SplineHash()
    var transformHash = TransformHashExtended()
    var lineThicknessType = RenderLineThicknessType.a
    
    public mutating func change(splineHash: SplineHash,
                         centerX: Float,
                         centerY: Float,
                         scale: Float,
                         rotation: Float,
                         worldScale: Float,
                         lineThicknessType: RenderLineThicknessType) {
        transformHash.change(centerX: centerX,
                             centerY: centerY,
                             scale: scale,
                             rotation: rotation,
                             worldScale: worldScale)
        self.splineHash = splineHash
        self.lineThicknessType = lineThicknessType
    }
}

public struct OutlineHashGuide: Equatable {
    
    public init() {
        
    }
    
    var splineHash = SplineHash()
    var transformHashGuide = TransformHash()
    var transformHashJiggle = TransformHash()
    var lineThicknessType = RenderLineThicknessType.a
    public mutating func change(splineHash: SplineHash,
                         centerX: Float,
                         centerY: Float,
                         scale: Float,
                         rotation: Float,
                         jiggleCenterX: Float,
                         jiggleCenterY: Float,
                         jiggleScale: Float,
                         jiggleRotation: Float,
                         lineThicknessType: RenderLineThicknessType) {
        
        transformHashGuide.change(centerX: centerX,
                             centerY: centerY,
                             scale: scale,
                             rotation: rotation)
        transformHashJiggle.change(centerX: jiggleCenterX,
                                   centerY: jiggleCenterY,
                                   scale: jiggleScale,
                                   rotation: jiggleRotation)
        self.splineHash = splineHash
        
        self.lineThicknessType = lineThicknessType
    }
}

public struct OutlineHashGuideExtended: Equatable {
    
    public init() {
        
    }
    
    var splineHash = SplineHash()
    var transformHashGuide = TransformHashExtended()
    var transformHashJiggle = TransformHash()
    var lineThicknessType = RenderLineThicknessType.a
    
    public mutating func change(splineHash: SplineHash,
                         centerX: Float,
                         centerY: Float,
                         scale: Float,
                         rotation: Float,
                         worldScale: Float,
                         jiggleCenterX: Float,
                         jiggleCenterY: Float,
                         jiggleScale: Float,
                         jiggleRotation: Float,
                         lineThicknessType: RenderLineThicknessType) {
        transformHashGuide.change(centerX: centerX,
                                       centerY: centerY,
                                       scale: scale,
                                       rotation: rotation,
                                       worldScale: worldScale)
        transformHashJiggle.change(centerX: jiggleCenterX,
                                   centerY: jiggleCenterY,
                                   scale: jiggleScale,
                                   rotation: jiggleRotation)
        self.splineHash = splineHash
        self.lineThicknessType = lineThicknessType
    }
}
