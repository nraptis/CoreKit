//
//  GuideRenderer+JigglePoints.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/29/24.
//

import Foundation
import Metal
import simd

extension GuideRenderer {
    
    public func getPointsCreatorModeFormat(creatorMode: CreatorMode) -> PointsCreatorModeFormat {
        let creatorModeFormat: PointsCreatorModeFormat
        switch creatorMode {
        case .none:
            creatorModeFormat = .regular
        case .makeJiggle:
            creatorModeFormat = .invalid
        case .drawJiggle:
            creatorModeFormat = .invalid
        case .addJigglePoint:
            creatorModeFormat = .invalid
        case .deleteJigglePoint:
            creatorModeFormat = .invalid
        case .makeGuide:
            creatorModeFormat = .invalid
        case .drawGuide:
            creatorModeFormat = .invalid
        case .addGuidePoint:
            if isSelected {
                creatorModeFormat = .regular
            } else {
                creatorModeFormat = .alternative
            }
        case .deleteGuidePoint:
            creatorModeFormat = .regular
        case .moveJiggleCenter:
            creatorModeFormat = .alternative
        case .moveGuideCenter:
            creatorModeFormat = .alternative
        }
        return creatorModeFormat
    }
    
    // This is mainly just to compute the colors...
    // We only do it *ONCE* for both Precise and Regular...
    public func pre_preparePoints(renderInfo: JiggleRenderInfo) {
        
        guard renderInfo.isShowingGuidePoints else { return }
        
        if isFrozen {
            color_points_unmodified_unselected_stroke = RTJ.strokeDis(isDarkModeEnabled: isDarkModeEnabled)
            color_points_unmodified_unselected_fill = RTJ.fillDis(isDarkModeEnabled: isDarkModeEnabled)
            color_points_modified_unselected_stroke = RTJ.strokeDis(isDarkModeEnabled: isDarkModeEnabled)
            color_points_modified_unselected_fill = RTJ.fillDis(isDarkModeEnabled: isDarkModeEnabled)
            return
        }
        
        switch pointsCreatorModeFormat {
        case .regular, .invalid:
            if isJiggleSelected {
                color_points_unmodified_unselected_stroke = RTJ.strokeRegSel(isDarkModeEnabled: isDarkModeEnabled)
                color_points_unmodified_unselected_fill = RTG.fillRegSelUnm(index: weightDepthIndex,
                                                                            isDarkModeEnabled: isDarkModeEnabled)
                color_points_modified_unselected_stroke = RTJ.strokeRegSel(isDarkModeEnabled: isDarkModeEnabled)
                color_points_modified_unselected_fill = RTG.fillRegSelMod(index: weightDepthIndex,
                                                                          isDarkModeEnabled: isDarkModeEnabled)
                color_points_selected_stroke = RTJ.strokeRegSel(isDarkModeEnabled: isDarkModeEnabled)
                color_points_selected_fill = RTJ.fillGrb(isDarkModeEnabled: isDarkModeEnabled)
                
                color_points_unmodified_tanselected_fill = RTG.fillRegSelUnm(index: weightDepthIndex,
                                                                             isDarkModeEnabled: isDarkModeEnabled)
                color_points_modified_tanselected_fill = RTG.fillRegSelMod(index: weightDepthIndex,
                                                                           isDarkModeEnabled: isDarkModeEnabled)
            } else {
                color_points_unmodified_unselected_stroke = RTJ.strokeRegUns(isDarkModeEnabled: isDarkModeEnabled)
                color_points_unmodified_unselected_fill = RTG.fillRegUnsUnm(index: weightDepthIndex,
                                                                            isDarkModeEnabled: isDarkModeEnabled)
                color_points_modified_unselected_stroke = RTJ.strokeRegUns(isDarkModeEnabled: isDarkModeEnabled)
                color_points_modified_unselected_fill = RTG.fillRegUnsMod(index: weightDepthIndex,
                                                                          isDarkModeEnabled: isDarkModeEnabled)
            }
        case .alternative:
            if isJiggleSelected {
                color_points_unmodified_unselected_stroke = RTJ.strokeAltSel(isDarkModeEnabled: isDarkModeEnabled)
                color_points_unmodified_unselected_fill = RTJ.fillAltSelUnm(isDarkModeEnabled: isDarkModeEnabled)
                color_points_modified_unselected_stroke = RTJ.strokeAltSel(isDarkModeEnabled: isDarkModeEnabled)
                color_points_modified_unselected_fill = RTJ.fillAltSelMod(isDarkModeEnabled: isDarkModeEnabled)
                color_points_selected_stroke = RTJ.strokeRegSel(isDarkModeEnabled: isDarkModeEnabled)
                color_points_selected_fill = RTJ.fillGrb(isDarkModeEnabled: isDarkModeEnabled)
                color_points_unmodified_tanselected_fill = RTG.fillRegSelUnm(index: weightDepthIndex,
                                                                             isDarkModeEnabled: isDarkModeEnabled)
                color_points_modified_tanselected_fill = RTG.fillRegSelMod(index: weightDepthIndex,
                                                                           isDarkModeEnabled: isDarkModeEnabled)
            } else {
                color_points_unmodified_unselected_stroke = RTJ.strokeAltUns(isDarkModeEnabled: isDarkModeEnabled)
                color_points_unmodified_unselected_fill = RTJ.fillAltUnsUnm(isDarkModeEnabled: isDarkModeEnabled)
                color_points_modified_unselected_stroke = RTJ.strokeAltUns(isDarkModeEnabled: isDarkModeEnabled)
                color_points_modified_unselected_fill = RTJ.fillAltUnsMod(isDarkModeEnabled: isDarkModeEnabled)
            }
        }
    }
    
    public func preparePoints(renderInfo: JiggleRenderInfo,
                       guidePoints: [GuidePoint],
                       guidePointCount: Int,
                       pointsUnselectedBloomBuffer: IndexedSpriteBuffer3D,
                       pointsUnselectedUnmodifiedStrokeBuffer: IndexedSpriteBuffer2D,
                       pointsUnselectedUnmodifiedFillBuffer: IndexedSpriteBuffer2D,
                       pointsUnselectedModifiedStrokeBuffer: IndexedSpriteBuffer2D,
                       pointsUnselectedModifiedFillBuffer: IndexedSpriteBuffer2D,
                       pointsSelectedBloomBuffer: IndexedSpriteBuffer3D,
                       pointsSelectedStrokeBuffer: IndexedSpriteBuffer2D,
                       pointsSelectedFillBuffer: IndexedSpriteBuffer2DColored,
                       isPrecisePass: Bool,
                       graphicsWidth: Float,
                       graphicsHeight: Float) {
        
        guard renderInfo.isShowingGuidePoints else { return }
        
        switch pointsCreatorModeFormat {
        case .invalid:
            return
        default:
            break
        }
        
        let isBloom = (isBloomMode && renderInfo.isShowingGuidePointsBloom)
        
        if isBloom {
            pointsUnselectedBloomBuffer.projectionMatrix = orthoMatrix
            pointsUnselectedBloomBuffer.rgba = color_bloom
        }
        
        pointsUnselectedUnmodifiedStrokeBuffer.projectionMatrix = orthoMatrix
        pointsUnselectedUnmodifiedStrokeBuffer.rgba = color_points_unmodified_unselected_stroke
        
        pointsUnselectedUnmodifiedFillBuffer.projectionMatrix = orthoMatrix
        pointsUnselectedUnmodifiedFillBuffer.rgba = color_points_unmodified_unselected_fill
        
        pointsUnselectedModifiedStrokeBuffer.projectionMatrix = orthoMatrix
        pointsUnselectedModifiedStrokeBuffer.rgba = color_points_modified_unselected_stroke
        
        pointsUnselectedModifiedFillBuffer.projectionMatrix = orthoMatrix
        pointsUnselectedModifiedFillBuffer.rgba = color_points_modified_unselected_fill
        
        if isBloom {
            pointsSelectedBloomBuffer.projectionMatrix = orthoMatrix
            pointsSelectedBloomBuffer.rgba = color_bloom
        }
        
        pointsSelectedStrokeBuffer.projectionMatrix = orthoMatrix
        pointsSelectedStrokeBuffer.rgba = color_points_selected_stroke
        
        pointsSelectedFillBuffer.projectionMatrix = orthoMatrix
        
        for guidePointIndex in 0..<guidePointCount {
            let guidePoint = guidePoints[guidePointIndex]
            
            var renderCenterPoint = Math.Point(x: guidePoint.renderX,
                                               y: guidePoint.renderY)
            renderCenterPoint = projectionMatrix.process2d(point: renderCenterPoint,
                                                           screenWidth: graphicsWidth,
                                                           screenHeight: graphicsHeight)
            
            switch guidePoint.renderPointSelected {
                
            case .ignore:
                if isBloom {
                    pointsUnselectedBloomBuffer.add(translation: renderCenterPoint)
                }
                if guidePoint.isManualTanHandleEnabledIn || guidePoint.isManualTanHandleEnabledOut {
                    pointsUnselectedModifiedStrokeBuffer.add(translation: renderCenterPoint)
                    pointsUnselectedModifiedFillBuffer.add(translation: renderCenterPoint)
                } else {
                    pointsUnselectedUnmodifiedStrokeBuffer.add(translation: renderCenterPoint)
                    pointsUnselectedUnmodifiedFillBuffer.add(translation: renderCenterPoint)
                }
            case .unselected:
                if isBloom {
                    pointsSelectedBloomBuffer.add(translation: renderCenterPoint)
                }
                pointsSelectedStrokeBuffer.add(translation: renderCenterPoint)
                if guidePoint.isManualTanHandleEnabledIn || guidePoint.isManualTanHandleEnabledOut {
                    pointsSelectedFillBuffer.add(translation: renderCenterPoint,
                                                 red: color_points_modified_tanselected_fill.red,
                                                 green: color_points_modified_tanselected_fill.green,
                                                 blue: color_points_modified_tanselected_fill.blue,
                                                 alpha: 1.0)
                } else {
                    pointsSelectedFillBuffer.add(translation: renderCenterPoint,
                                                 red: color_points_unmodified_tanselected_fill.red,
                                                 green: color_points_unmodified_tanselected_fill.green,
                                                 blue: color_points_unmodified_tanselected_fill.blue,
                                                 alpha: 1.0)
                }
            case .selected:
                if isBloom {
                    pointsSelectedBloomBuffer.add(translation: renderCenterPoint)
                }
                pointsSelectedStrokeBuffer.add(translation: renderCenterPoint)
                pointsSelectedFillBuffer.add(translation: renderCenterPoint,
                                             red: color_points_selected_fill.red,
                                             green: color_points_selected_fill.green,
                                             blue: color_points_selected_fill.blue,
                                             alpha: 1.0)
            }
        }
    }
    
    public func renderPointsUnselectedBloomRegular(renderEncoder: MTLRenderCommandEncoder,
                                            renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if renderInfo.isShowingGuidePointsBloom {
                    pointsUnselectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    public func renderPointsUnselectedUnmodifiedStrokeRegular(renderEncoder: MTLRenderCommandEncoder,
                                                       renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingGuidePoints {
            pointsUnselectedUnmodifiedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderPointsUnselectedUnmodifiedFillRegular(renderEncoder: MTLRenderCommandEncoder,
                                                     renderInfo: JiggleRenderInfo) {
        
        if renderInfo.isShowingGuidePoints {
            pointsUnselectedUnmodifiedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
        
    }
    
    public func renderPointsUnselectedModifiedStrokeRegular(renderEncoder: MTLRenderCommandEncoder,
                                                     renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingGuidePoints {
            pointsUnselectedModifiedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
        
    }
    
    public func renderPointsUnselectedModifiedFillRegular(renderEncoder: MTLRenderCommandEncoder,
                                                   renderInfo: JiggleRenderInfo) {
        
        if renderInfo.isShowingGuidePoints {
            pointsUnselectedModifiedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                             pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
        
    }
    
    public func renderPointsUnselectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder,
                                            renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if renderInfo.isShowingGuidePointsBloom {
                    pointsUnselectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
                
            }
        }
    }
    
    public func renderPointsUnselectedUnmodifiedStrokePrecise(renderEncoder: MTLRenderCommandEncoder,
                                                       renderInfo: JiggleRenderInfo) {
        
        if renderInfo.isShowingGuidePoints {
            pointsUnselectedUnmodifiedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
        
    }
    
    public func renderPointsUnselectedUnmodifiedFillPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                     renderInfo: JiggleRenderInfo) {
        
        if renderInfo.isShowingGuidePoints {
            pointsUnselectedUnmodifiedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
        
    }
    
    public func renderPointsUnselectedModifiedStrokePrecise(renderEncoder: MTLRenderCommandEncoder,
                                                     renderInfo: JiggleRenderInfo) {
        
        if renderInfo.isShowingGuidePoints {
            pointsUnselectedModifiedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderPointsUnselectedModifiedFillPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                   renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingGuidePoints {
            pointsUnselectedModifiedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                             pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderPointsSelectedBloomRegular(renderEncoder: MTLRenderCommandEncoder,
                                          renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if renderInfo.isShowingGuidePointsBloom {
                    pointsSelectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                            pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    public func renderPointsSelectedStrokeRegular(renderEncoder: MTLRenderCommandEncoder,
                                           renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingGuidePoints {
            pointsSelectedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                     pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderPointsSelectedFillRegular(renderEncoder: MTLRenderCommandEncoder,
                                         renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingGuidePoints {
            pointsSelectedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                   pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
        }
        
    }
    
    public func renderPointsSelectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder,
                                          renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if renderInfo.isShowingGuidePointsBloom {
                    pointsSelectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                            pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
                
            }
        }
    }
    
    public func renderPointsSelectedStrokePrecise(renderEncoder: MTLRenderCommandEncoder,
                                           renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingGuidePoints {
            pointsSelectedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                     pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderPointsSelectedFillPrecise(renderEncoder: MTLRenderCommandEncoder,
                                         renderInfo: JiggleRenderInfo) {
        
            if renderInfo.isShowingGuidePoints {
                pointsSelectedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                       pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
            }
        
    }
    
}
