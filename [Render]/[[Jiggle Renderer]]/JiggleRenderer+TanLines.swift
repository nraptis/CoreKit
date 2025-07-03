//
//  JiggleRenderer+JigglePointTans.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/24/24.
//

import Foundation
import Metal
import simd

extension JiggleRenderer {
    
    public func getTansCreatorModeFormat(creatorMode: CreatorMode) -> TansCreatorModeFormat {
        let creatorModeFormat: TansCreatorModeFormat
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
            creatorModeFormat = .invalid
        case .deleteGuidePoint:
            creatorModeFormat = .invalid
        case .moveJiggleCenter:
            creatorModeFormat = .invalid
        case .moveGuideCenter:
            creatorModeFormat = .invalid
        }
        return creatorModeFormat
    }
    
    public func pre_prepareTanLines(renderInfo: JiggleRenderInfo) {
        
        guard renderInfo.isShowingJigglePointTanHandles else { return }
        
        if isJiggleFrozen {
            color_tan_lines_unselected_stroke = RTJ.strokeDis(isDarkModeEnabled: isDarkModeEnabled)
            color_tan_lines_unselected_fill = RTJ.fillDis(isDarkModeEnabled: isDarkModeEnabled)
            return
        }
        
        switch tansCreatorModeFormat {
        case .regular, .invalid:
            if isJiggleSelected {
                color_tan_lines_unselected_stroke = RTJ.strokeRegSel(isDarkModeEnabled: isDarkModeEnabled)
                color_tan_lines_unselected_fill = RTJ.fillRegSelMod(isDarkModeEnabled: isDarkModeEnabled)
                color_tan_lines_selected_stroke = RTJ.strokeRegSel(isDarkModeEnabled: isDarkModeEnabled)
                color_tan_lines_selected_fill = RTJ.fillGrb(isDarkModeEnabled: isDarkModeEnabled)
            } else {
                color_tan_lines_unselected_stroke = RTJ.strokeRegUns(isDarkModeEnabled: isDarkModeEnabled)
                color_tan_lines_unselected_fill = RTJ.fillRegUnsMod(isDarkModeEnabled: isDarkModeEnabled)
            }
        case .alternative:
            if isJiggleSelected {
                color_tan_lines_unselected_stroke = RTJ.strokeAltSel(isDarkModeEnabled: isDarkModeEnabled)
                color_tan_lines_unselected_fill = RTJ.fillAltSelMod(isDarkModeEnabled: isDarkModeEnabled)
            } else {
                color_tan_lines_unselected_stroke = RTJ.strokeAltUns(isDarkModeEnabled: isDarkModeEnabled)
                color_tan_lines_unselected_fill = RTJ.fillAltUnsMod(isDarkModeEnabled: isDarkModeEnabled)
            }
        }
    }
    
    public func prepareTanLines(renderInfo: JiggleRenderInfo,
                                jigglePoints: [JigglePoint],
                         jigglePointCount: Int,
                         tanHandleLinesBloomBuffer: IndexedShapeBuffer3D,
                         tanHandleLinesUnselectedStrokeBuffer: IndexedShapeBuffer2D,
                         tanHandleLinesUnselectedFillBuffer: IndexedShapeBuffer2D,
                         tanHandleLinesSelectedStrokeBuffer: IndexedShapeBuffer2D,
                         tanHandleLinesSelectedFillBuffer: IndexedShapeBuffer2D,
                         isPrecisePass: Bool) {
        
        guard renderInfo.isShowingJigglePointTanHandles else { return }
        
        switch tansCreatorModeFormat {
        case .invalid:
            return
        default:
            break
        }
        
        let isBloom = (isBloomMode && renderInfo.isShowingJigglePointTanHandlesBloom)
        
        let lineWidthFill = lineWidthFillBase * worldScale
        let lineWidthStroke = lineWidthStrokeBase * worldScale
        
        if isBloom {
            tanHandleLinesBloomBuffer.projectionMatrix = projectionMatrix
            tanHandleLinesBloomBuffer.rgba = color_bloom
        }
        
        tanHandleLinesUnselectedStrokeBuffer.projectionMatrix = projectionMatrix
        tanHandleLinesUnselectedStrokeBuffer.rgba = color_tan_lines_unselected_stroke
        
        tanHandleLinesUnselectedFillBuffer.projectionMatrix = projectionMatrix
        tanHandleLinesUnselectedFillBuffer.rgba = color_tan_lines_unselected_fill
        
        tanHandleLinesSelectedStrokeBuffer.projectionMatrix = projectionMatrix
        tanHandleLinesSelectedStrokeBuffer.rgba = color_tan_lines_selected_stroke
        
        tanHandleLinesSelectedFillBuffer.projectionMatrix = projectionMatrix
        tanHandleLinesSelectedFillBuffer.rgba = color_tan_lines_selected_fill
        
        for jigglePointIndex in 0..<jigglePointCount {
            let jigglePoint = jigglePoints[jigglePointIndex]
            
            let tanHandleInX = jigglePoint.renderTanInX
            let tanHandleInY = jigglePoint.renderTanInY
            let tanHandleOutX = jigglePoint.renderTanOutX
            let tanHandleOutY = jigglePoint.renderTanOutY
            let tanNormalInX = jigglePoint.renderTanNormalInX
            let tanNormalInY = jigglePoint.renderTanNormalInY
            let tanNormalOutX = jigglePoint.renderTanNormalOutX
            let tanNormalOutY = jigglePoint.renderTanNormalOutY
            
            let renderX = jigglePoint.renderX
            let renderY = jigglePoint.renderY
            
            let strokeBoxIn = LineBox.getLineBox(x1: tanHandleInX, y1: tanHandleInY,
                                                 x2: renderX, y2: renderY,
                                                 normalX: tanNormalInX, normalY: tanNormalInY,
                                                 thickness: lineWidthStroke)
            let fillBoxIn = LineBox.getLineBox(x1: tanHandleInX, y1: tanHandleInY,
                                               x2: renderX, y2: renderY,
                                               normalX: tanNormalInX, normalY: tanNormalInY,
                                               thickness: lineWidthFill)
            let strokeBoxOut = LineBox.getLineBox(x1: renderX, y1: renderY,
                                                  x2: tanHandleOutX, y2: tanHandleOutY,
                                                  normalX: tanNormalOutX, normalY: tanNormalOutY,
                                                  thickness: lineWidthStroke)
            let fillBoxOut = LineBox.getLineBox(x1: renderX, y1: renderY,
                                                x2: tanHandleOutX, y2: tanHandleOutY,
                                                normalX: tanNormalOutX, normalY: tanNormalOutY,
                                                thickness: lineWidthFill)
            
            if isBloom {
                tanHandleLinesBloomBuffer.add(cornerX1: strokeBoxIn.x1, cornerY1: strokeBoxIn.y1,
                                              cornerX2: strokeBoxIn.x2, cornerY2: strokeBoxIn.y2,
                                              cornerX3: strokeBoxIn.x3, cornerY3: strokeBoxIn.y3,
                                              cornerX4: strokeBoxIn.x4, cornerY4: strokeBoxIn.y4)
                tanHandleLinesBloomBuffer.add(cornerX1: strokeBoxOut.x1, cornerY1: strokeBoxOut.y1,
                                              cornerX2: strokeBoxOut.x2, cornerY2: strokeBoxOut.y2,
                                              cornerX3: strokeBoxOut.x3, cornerY3: strokeBoxOut.y3,
                                              cornerX4: strokeBoxOut.x4, cornerY4: strokeBoxOut.y4)
            }
            
            if jigglePoint.renderTanInSelected {
                tanHandleLinesSelectedStrokeBuffer.add(cornerX1: strokeBoxIn.x1, cornerY1: strokeBoxIn.y1,
                                                       cornerX2: strokeBoxIn.x2, cornerY2: strokeBoxIn.y2,
                                                       cornerX3: strokeBoxIn.x3, cornerY3: strokeBoxIn.y3,
                                                       cornerX4: strokeBoxIn.x4, cornerY4: strokeBoxIn.y4)
                tanHandleLinesSelectedFillBuffer.add(cornerX1: fillBoxIn.x1, cornerY1: fillBoxIn.y1,
                                                     cornerX2: fillBoxIn.x2, cornerY2: fillBoxIn.y2,
                                                     cornerX3: fillBoxIn.x3, cornerY3: fillBoxIn.y3,
                                                     cornerX4: fillBoxIn.x4, cornerY4: fillBoxIn.y4)
            } else {
                tanHandleLinesUnselectedStrokeBuffer.add(cornerX1: strokeBoxIn.x1, cornerY1: strokeBoxIn.y1,
                                                         cornerX2: strokeBoxIn.x2, cornerY2: strokeBoxIn.y2,
                                                         cornerX3: strokeBoxIn.x3, cornerY3: strokeBoxIn.y3,
                                                         cornerX4: strokeBoxIn.x4, cornerY4: strokeBoxIn.y4)
                tanHandleLinesUnselectedFillBuffer.add(cornerX1: fillBoxIn.x1, cornerY1: fillBoxIn.y1,
                                                       cornerX2: fillBoxIn.x2, cornerY2: fillBoxIn.y2,
                                                       cornerX3: fillBoxIn.x3, cornerY3: fillBoxIn.y3,
                                                       cornerX4: fillBoxIn.x4, cornerY4: fillBoxIn.y4)
            }
            
            if jigglePoint.renderTanOutSelected {
                tanHandleLinesSelectedStrokeBuffer.add(cornerX1: strokeBoxOut.x1, cornerY1: strokeBoxOut.y1,
                                                       cornerX2: strokeBoxOut.x2, cornerY2: strokeBoxOut.y2,
                                                       cornerX3: strokeBoxOut.x3, cornerY3: strokeBoxOut.y3,
                                                       cornerX4: strokeBoxOut.x4, cornerY4: strokeBoxOut.y4)
                tanHandleLinesSelectedFillBuffer.add(cornerX1: fillBoxOut.x1, cornerY1: fillBoxOut.y1,
                                                     cornerX2: fillBoxOut.x2, cornerY2: fillBoxOut.y2,
                                                     cornerX3: fillBoxOut.x3, cornerY3: fillBoxOut.y3,
                                                     cornerX4: fillBoxOut.x4, cornerY4: fillBoxOut.y4)
            } else {
                tanHandleLinesUnselectedStrokeBuffer.add(cornerX1: strokeBoxOut.x1, cornerY1: strokeBoxOut.y1,
                                                         cornerX2: strokeBoxOut.x2, cornerY2: strokeBoxOut.y2,
                                                         cornerX3: strokeBoxOut.x3, cornerY3: strokeBoxOut.y3,
                                                         cornerX4: strokeBoxOut.x4, cornerY4: strokeBoxOut.y4)
                tanHandleLinesUnselectedFillBuffer.add(cornerX1: fillBoxOut.x1, cornerY1: fillBoxOut.y1,
                                                       cornerX2: fillBoxOut.x2, cornerY2: fillBoxOut.y2,
                                                       cornerX3: fillBoxOut.x3, cornerY3: fillBoxOut.y3,
                                                       cornerX4: fillBoxOut.x4, cornerY4: fillBoxOut.y4)
            }
        }
    }
    
    public func renderTanHandleLinesBloomRegular(renderEncoder: MTLRenderCommandEncoder,
                                          renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if renderInfo.isShowingJigglePointTanHandlesBloom {
                tanHandleLinesRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                        pipelineState: .shapeNodeIndexed3DNoBlending)
            }
        }
    }
    
    public func renderTanHandleLinesUnselectedStrokeRegular(renderEncoder: MTLRenderCommandEncoder,
                                                     renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePointTanHandles {
            tanHandleLinesUnselectedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                               pipelineState: .shapeNodeIndexed2DNoBlending)
        }
    }
    
    public func renderTanHandleLinesUnselectedFillRegular(renderEncoder: MTLRenderCommandEncoder,
                                                   renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePointTanHandles {
            tanHandleLinesUnselectedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                             pipelineState: .shapeNodeIndexed2DNoBlending)
        }
    }
    
    public func renderTanHandleLinesBloomPrecise(renderEncoder: MTLRenderCommandEncoder,
                                          renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if renderInfo.isShowingJigglePointTanHandlesBloom {
                tanHandleLinesPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                        pipelineState: .shapeNodeIndexed3DNoBlending)
            }
        }
    }
    
    public func renderTanHandleLinesUnselectedStrokePrecise(renderEncoder: MTLRenderCommandEncoder,
                                                     renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePointTanHandles {
            tanHandleLinesUnselectedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                               pipelineState: .shapeNodeIndexed2DNoBlending)
        }
    }
    
    public func renderTanHandleLinesUnselectedFillPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                   renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePointTanHandles {
            tanHandleLinesUnselectedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                             pipelineState: .shapeNodeIndexed2DNoBlending)
        }
    }
    
    public func renderTanHandleLinesSelectedStrokeRegular(renderEncoder: MTLRenderCommandEncoder,
                                                   renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePointTanHandles {
            tanHandleLinesSelectedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                             pipelineState: .shapeNodeIndexed2DNoBlending)
        }
    }
    
    public func renderTanHandleLinesSelectedFillRegular(renderEncoder: MTLRenderCommandEncoder,
                                                 renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePointTanHandles {
            tanHandleLinesSelectedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                           pipelineState: .shapeNodeIndexed2DNoBlending)
        }
    }
    
    public func renderTanHandleLinesSelectedStrokePrecise(renderEncoder: MTLRenderCommandEncoder,
                                                   renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePointTanHandles {
            tanHandleLinesSelectedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                             pipelineState: .shapeNodeIndexed2DNoBlending)
        }
    }
    
    public func renderTanHandleLinesSelectedFillPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                 renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePointTanHandles {
            tanHandleLinesSelectedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                           pipelineState: .shapeNodeIndexed2DNoBlending)
        }
    }
    
}
