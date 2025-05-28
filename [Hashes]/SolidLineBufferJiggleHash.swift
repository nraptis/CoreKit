//
//  SolidLineBufferJiggleHash.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 7/8/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public struct SolidLineBufferJiggleHash: Equatable {
    
    public init() {
        
    }
    
    var outlineHash = OutlineHashExtended()
    var isJiggleSelected = false
    var isJiggleFrozen = false
    var isDarkMode = false
    var isGuidesMode = false
    var creatorMode = CreatorMode.none
    var editMode = EditMode.jiggles
    
    public mutating func change(splineHash: SplineHash,
                         worldScale: Float,
                         creatorMode: CreatorMode,
                         editMode: EditMode,
                         isGuidesMode: Bool,
                         centerX: Float,
                         centerY: Float,
                         scale: Float,
                         rotation: Float,
                         isJiggleSelected: Bool,
                         isJiggleFrozen: Bool,
                         isDarkMode: Bool,
                         lineThicknessType: RenderLineThicknessType) {
        
        self.creatorMode = creatorMode
        self.editMode = editMode
        self.isGuidesMode = isGuidesMode
        
        outlineHash.change(splineHash: splineHash,
                           centerX: centerX,
                           centerY: centerY,
                           scale: scale,
                           rotation: rotation,
                           worldScale: worldScale,
                           lineThicknessType: lineThicknessType)
        
        self.isJiggleSelected = isJiggleSelected
        self.isJiggleFrozen = isJiggleFrozen
        self.isDarkMode = isDarkMode
        
    }
    
    public mutating func invalidate() {
        outlineHash.invalidate()
    }
    
}
