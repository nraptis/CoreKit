//
//  BorderHash.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 7/8/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public struct SolidLineBufferGuideHash: Equatable {
    
    public init() {
        
    }
    
    var outlineHash = OutlineHashGuideExtended()
    var isGuideSelected = false
    var isJiggleSelected = false
    var isJiggleFrozen = false
    var isGuideFrozen = false
    var isDarkMode = false
    var weightDepthIndex = -1
    var guideCount = -1
    var creatorMode = CreatorMode.none
    var weightMode = WeightMode.guides
    
    public mutating func change(splineHash: SplineHash,
                         centerX: Float,
                         centerY: Float,
                         scale: Float,
                         rotation: Float,
                         worldScale: Float,
                         creatorMode: CreatorMode,
                         weightMode: WeightMode,
                         isGuideSelected: Bool,
                         isJiggleSelected: Bool,
                         isJiggleFrozen: Bool,
                         isGuideFrozen: Bool,
                         isDarkMode: Bool,
                         weightDepthIndex: Int,
                         guideCount: Int,
                         jiggleCenterX: Float,
                         jiggleCenterY: Float,
                         jiggleScale: Float,
                         jiggleRotation: Float,
                         lineThicknessType: RenderLineThicknessType) {
        
        outlineHash.change(splineHash: splineHash,
                           centerX: centerX,
                           centerY: centerY,
                           scale: scale,
                           rotation: rotation,
                           worldScale: worldScale,
                           jiggleCenterX: jiggleCenterX,
                           jiggleCenterY: jiggleCenterY,
                           jiggleScale: jiggleScale,
                           jiggleRotation: jiggleRotation,
                           lineThicknessType: lineThicknessType)
        
        self.isJiggleSelected = isJiggleSelected
        self.isGuideSelected = isGuideSelected
        self.isJiggleFrozen = isJiggleFrozen
        self.isGuideFrozen = isGuideFrozen
        self.isDarkMode = isDarkMode
        self.weightDepthIndex = weightDepthIndex
        self.guideCount = guideCount
        self.creatorMode = creatorMode
        self.weightMode = weightMode
    }
    
    public mutating func invalidate() {
        outlineHash.invalidate()
    }
}
