//
//  Jiggle+TriangleBufferRefresh.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/9/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public extension Jiggle {
    
    func refreshTriangleBufferEditStandard(isDarkMode: Bool,
                                           isJiggleSelected: Bool,
                                           isJiggleFrozen: Bool,
                                           opacityPercent: Float) {
        jiggleMesh.refreshTriangleBufferEditStandard(isSelected: isJiggleSelected,
                                                     isFrozen: isJiggleFrozen,
                                                     isDarkMode: isDarkMode,
                                                     opacityPercent: opacityPercent)
        currentHashTrianglesStandard.change(polyHash: currentHashPoly,
                                            isSelected: isJiggleSelected,
                                            isFrozen: isJiggleFrozen,
                                            isDarkMode: isDarkMode,
                                            centerX: center.x,
                                            centerY: center.y,
                                            scale: scale,
                                            rotation: rotation)
    }
    
    func refreshTriangleBufferEditWeights(isDarkMode: Bool,
                                          isJiggleSelected: Bool,
                                          isJiggleFrozen: Bool,
                                          opacityPercent: Float) {
        jiggleMesh.refreshTriangleBufferEditWeights(isSelected: isJiggleSelected,
                                                    isFrozen: isJiggleFrozen,
                                                    isDarkMode: isDarkMode,
                                                    sortedGuideCount: sortedGuideCount,
                                                    opacityPercent: opacityPercent)
        currentHashTrianglesWeights.change(polyHash: currentHashPoly,
                                           isSelected: isJiggleSelected,
                                           isFrozen: isJiggleFrozen,
                                           isDarkMode: isDarkMode,
                                           centerX: center.x,
                                           centerY: center.y,
                                           scale: scale,
                                           rotation: rotation)
    }
    
    func refreshTriangleBuffersSwivel(isDarkMode: Bool) {
        jiggleMesh.refreshTriangleBuffersSwivel(isDarkMode: isDarkMode,
                                                sortedGuideCount: sortedGuideCount)
        currentHashTrianglesSwivel.change(polyHash: currentHashPoly,
                                          isSelected: true,
                                          isFrozen: false,
                                          isDarkMode: isDarkMode,
                                          centerX: center.x,
                                          centerY: center.y,
                                          scale: scale,
                                          rotation: rotation)
    }
    
    func refreshTriangleBuffersViewStandard() {
        jiggleMesh.refreshTriangleBuffersViewStandard()
        currentHashTrianglesViewStandard.change(polyHash: currentHashPoly,
                                                isSelected: true,
                                                isFrozen: false,
                                                isDarkMode: false,
                                                centerX: center.x,
                                                centerY: center.y,
                                                scale: scale,
                                                rotation: rotation)
    }
    
    @MainActor func refreshTriangleBuffersViewStereoscopic(stereoSpreadBase: Float,
                                                           stereoSpreadMax: Float) {
        jiggleMesh.refreshTriangleBuffersViewStereoscopic(stereoSpreadBase: stereoSpreadBase,
                                                          stereoSpreadMax: stereoSpreadMax)
        
        currentHashTrianglesViewStereoscopic.change(polyHash: currentHashPoly,
                                                    isSelected: true,
                                                    isFrozen: false,
                                                    isDarkMode: false,
                                                    centerX: center.x,
                                                    centerY: center.y,
                                                    scale: scale,
                                                    rotation: rotation)
    }
}
