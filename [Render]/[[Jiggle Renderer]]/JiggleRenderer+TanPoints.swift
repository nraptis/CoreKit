//
//  JiggleRenderer+JigglePointTanPoints.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/25/24.
//

import Foundation
import Metal
import simd

extension JiggleRenderer {
    
    public func pre_prepareTanPoints(renderInfo: JiggleRenderInfo) {
        
        guard renderInfo.isShowingJigglePointTanHandles else { return }
        
        if isJiggleFrozen {
            color_tan_points_unselected_stroke = RTJ.strokeDis(isDarkModeEnabled: isDarkModeEnabled)
            color_tan_points_unselected_fill = RTJ.fillDis(isDarkModeEnabled: isDarkModeEnabled)
            return
        }
        
        switch tansCreatorModeFormat {
        case .regular, .invalid:
            if isJiggleSelected {
                color_tan_points_unselected_stroke = RTJ.strokeRegSel(isDarkModeEnabled: isDarkModeEnabled)
                color_tan_points_unselected_fill = RTJ.tanPointFillSel(isDarkModeEnabled: isDarkModeEnabled)
                color_tan_points_selected_stroke = RTJ.strokeRegSel(isDarkModeEnabled: isDarkModeEnabled)
                color_tan_points_selected_fill = RTJ.fillGrb(isDarkModeEnabled: isDarkModeEnabled)
            } else {
                color_tan_points_unselected_stroke = RTJ.strokeRegUns(isDarkModeEnabled: isDarkModeEnabled)
                color_tan_points_unselected_fill = RTJ.tanPointFillUns(isDarkModeEnabled: isDarkModeEnabled)
            }
        case .alternative:
            if isJiggleSelected {
                color_tan_points_unselected_stroke = RTJ.strokeAltSel(isDarkModeEnabled: isDarkModeEnabled)
                color_tan_points_unselected_fill = RTJ.fillAltSelUnm(isDarkModeEnabled: isDarkModeEnabled)
            } else {
                color_tan_points_unselected_stroke = RTJ.strokeAltUns(isDarkModeEnabled: isDarkModeEnabled)
                color_tan_points_unselected_fill = RTJ.fillAltUnsUnm(isDarkModeEnabled: isDarkModeEnabled)
            }
        }
    }
    
    // @Precondition: pre_prepareTanPoints()
    // @Precondition: pre_prepareTanLines
    public func prepareTanPoints(renderInfo: JiggleRenderInfo,
                          jigglePoints: [JigglePoint],
                          jigglePointCount: Int,
                          tanHandlePointsUnselectedBloomBuffer: IndexedSpriteBuffer3D,
                          tanHandlePointsUnselectedStrokeBuffer: IndexedSpriteBuffer2D,
                          tanHandlePointsUnselectedFillBuffer: IndexedSpriteBuffer2D,
                          tanHandlePointsSelectedBloomBuffer: IndexedSpriteBuffer3D,
                          tanHandlePointsSelectedStrokeBuffer: IndexedSpriteBuffer2D,
                          tanHandlePointsSelectedFillBuffer: IndexedSpriteBuffer2D,
                          isPrecisePass: Bool,
                          graphicsWidth: Float,
                          graphicsHeight: Float) {
        
        guard renderInfo.isShowingJigglePointTanHandles else { return }
        
        switch tansCreatorModeFormat {
        case .invalid:
            return
        default:
            break
        }
        
        let isBloom = (isBloomMode && renderInfo.isShowingJigglePointTanHandlesBloom)
        
        if isBloom {
            tanHandlePointsUnselectedBloomBuffer.projectionMatrix = orthoMatrix
            tanHandlePointsUnselectedBloomBuffer.rgba = color_bloom
        }
        
        tanHandlePointsUnselectedStrokeBuffer.projectionMatrix = orthoMatrix
        tanHandlePointsUnselectedStrokeBuffer.rgba = color_tan_points_unselected_stroke
        
        tanHandlePointsUnselectedFillBuffer.projectionMatrix = orthoMatrix
        tanHandlePointsUnselectedFillBuffer.rgba = color_tan_points_unselected_fill
        
        if isBloom {
            tanHandlePointsSelectedBloomBuffer.projectionMatrix = orthoMatrix
            tanHandlePointsSelectedBloomBuffer.rgba = color_bloom
        }
        
        tanHandlePointsSelectedStrokeBuffer.projectionMatrix = orthoMatrix
        tanHandlePointsSelectedStrokeBuffer.rgba = color_tan_points_selected_stroke
        
        tanHandlePointsSelectedFillBuffer.projectionMatrix = orthoMatrix
        tanHandlePointsSelectedFillBuffer.rgba = color_tan_points_selected_fill
        
        for jigglePointIndex in 0..<jigglePointCount {
            let jigglePoint = jigglePoints[jigglePointIndex]
            var renderCenterPointIn = Math.Point(x: jigglePoint.renderTanInX,
                                                 y: jigglePoint.renderTanInY)
            renderCenterPointIn = projectionMatrix.process2d(point: renderCenterPointIn,
                                                             screenWidth: graphicsWidth,
                                                             screenHeight: graphicsHeight)
            
            var renderCenterPointOut = Math.Point(x: jigglePoint.renderTanOutX,
                                                  y: jigglePoint.renderTanOutY)
            renderCenterPointOut = projectionMatrix.process2d(point: renderCenterPointOut,
                                                              screenWidth: graphicsWidth,
                                                              screenHeight: graphicsHeight)
            
            if jigglePoint.renderTanInSelected {
                if isBloom {
                    tanHandlePointsSelectedBloomBuffer.add(translation: renderCenterPointIn)
                }
                tanHandlePointsSelectedStrokeBuffer.add(translation: renderCenterPointIn)
                tanHandlePointsSelectedFillBuffer.add(translation: renderCenterPointIn)
            } else {
                if isBloom {
                    tanHandlePointsUnselectedBloomBuffer.add(translation: renderCenterPointIn)
                }
                tanHandlePointsUnselectedStrokeBuffer.add(translation: renderCenterPointIn)
                tanHandlePointsUnselectedFillBuffer.add(translation: renderCenterPointIn)
            }
            
            if jigglePoint.renderTanOutSelected {
                if isBloom {
                    tanHandlePointsSelectedBloomBuffer.add(translation: renderCenterPointOut)
                }
                tanHandlePointsSelectedStrokeBuffer.add(translation: renderCenterPointOut)
                tanHandlePointsSelectedFillBuffer.add(translation: renderCenterPointOut)
                
            } else {
                if isBloom {
                    tanHandlePointsUnselectedBloomBuffer.add(translation: renderCenterPointOut)
                }
                tanHandlePointsUnselectedStrokeBuffer.add(translation: renderCenterPointOut)
                tanHandlePointsUnselectedFillBuffer.add(translation: renderCenterPointOut)
            }
        }
    }
    
    public func renderTanHandlePointsUnselectedBloomRegular(renderEncoder: MTLRenderCommandEncoder,
                                                     renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if renderInfo.isShowingJigglePointTanHandlesBloom {
                tanHandlePointsUnselectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .spriteNodeIndexed3DAlphaBlending)
            }
        }
    }
    
    public func renderTanHandlePointsUnselectedStrokeRegular(renderEncoder: MTLRenderCommandEncoder,
                                                      renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePointTanHandles {
            tanHandlePointsUnselectedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsUnselectedFillRegular(renderEncoder: MTLRenderCommandEncoder,
                                                    renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePointTanHandles {
            tanHandlePointsUnselectedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsUnselectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                     renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if renderInfo.isShowingJigglePointTanHandlesBloom {
                tanHandlePointsUnselectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .spriteNodeIndexed3DAlphaBlending)
            }
        }
    }
    
    public func renderTanHandlePointsUnselectedStrokePrecise(renderEncoder: MTLRenderCommandEncoder,
                                                      renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePointTanHandles {
            tanHandlePointsUnselectedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsUnselectedFillPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                    renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePointTanHandles {
            tanHandlePointsUnselectedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsSelectedBloomRegular(renderEncoder: MTLRenderCommandEncoder,
                                                   renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if renderInfo.isShowingJigglePointTanHandlesBloom {
                tanHandlePointsSelectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeIndexed3DAlphaBlending)
            }
        }
    }
    
    public func renderTanHandlePointsSelectedStrokeRegular(renderEncoder: MTLRenderCommandEncoder,
                                                    renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePointTanHandles {
            tanHandlePointsSelectedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsSelectedFillRegular(renderEncoder: MTLRenderCommandEncoder,
                                                  renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePointTanHandles {
            tanHandlePointsSelectedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                            pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsSelectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                   renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if renderInfo.isShowingJigglePointTanHandlesBloom {
                tanHandlePointsSelectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeIndexed3DAlphaBlending)
            }
        }
    }
    
    public func renderTanHandlePointsSelectedStrokePrecise(renderEncoder: MTLRenderCommandEncoder,
                                                    renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePointTanHandles {
            tanHandlePointsSelectedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsSelectedFillPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                  renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePointTanHandles {
            tanHandlePointsSelectedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                            pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
}
