//
//  HistoryController+Graph.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 6/2/25.
//

import Foundation

public extension HistoryController {
    
    func snapShotGraphReset_DragOnly() {
        
        print("snapShotGraphReset_DragOnly... (Status was \(snapShotGraphIsGraphDrag))")
        
        if snapShotGraphIsGraphDrag {
            snapShotGraphReset()
        }
        
    }
    
    func snapShotGraphReset() {
        snapShotGraphMode = .invalid
        snapShotGraphIsGraphDrag = false
    }
    
    //
    /*
     public struct SnapShotGraphDataControlPoint {
     public let selectedJiggleIndex: Int
     public let selectedGraphIndex: Int
     public let selectedJiggleAttribute: GrabAttribute
     }
     */
    
    func snapShotGraphAttributeControlPoint(attributeType: GraphAttributeType,
                                            selectedJiggle: Jiggle?,
                                            jiggles: [Jiggle],
                                            jiggleCount: Int,
                                            selectedGraphIndex: Int,
                                            isGraphDrag: Bool) -> Bool {
        
        switch snapShotGraphMode {
            
        case .appliedToControlPoint:
            print("[GRAPHTHIS] (snapShotGraphAttributeControlPoint) We are trying to snap-shot, but already have snap-shot mode of \"appliedToControlPoint\"...")
        case .appliedToEntireGraph:
            print("[GRAPHTHIS] (snapShotGraphAttributeControlPoint) We are trying to snap-shot, but already have snap-shot mode of \"appliedToEntireGraph\"...")
        case .invalid:
            break
        }
        
        
        if let selectedJiggle = selectedJiggle {
            if let selectedJiggleIndex = getJiggleIndex(selectedJiggle: selectedJiggle,
                                                        jiggles: jiggles,
                                                        jiggleCount: jiggleCount) {
                
                let selectedJiggleAttribute = readAttributeGraphControlPoint(jiggle: selectedJiggle,
                                                                             jiggleIndex: selectedJiggleIndex,
                                                                             graphIndex: selectedGraphIndex,
                                                                             attributeType: attributeType)
                
                
                let snapShotGraphDataControlPoint = SnapShotGraphDataControlPoint(selectedJiggleIndex: selectedJiggleIndex,
                                                                                  selectedGraphIndex: selectedGraphIndex,
                                                                                  selectedJiggleAttribute: selectedJiggleAttribute)
                
                snapShotGraphMode = .appliedToControlPoint(snapShotGraphDataControlPoint)
                snapShotGraphIsGraphDrag = isGraphDrag
                return true
                
            } else {
                snapShotGraphMode = .invalid
                print("[GRAPHTHIS] (snapShotGraphAttributeOne) We are trying to snap-shot, but selected jiggle does not exist in list...")
                return false
            }
            
        } else {
            snapShotGraphMode = .invalid
            print("[GRAPHTHIS] (snapShotGraphAttributeOne) We are trying to snap-shot, but selected jiggle is null...")
            return false
        }
    }
    
    func snapShotGraphAttributeEntireGraph(selectedJiggle: Jiggle?,
                                           jiggles: [Jiggle],
                                           jiggleCount: Int) -> Bool {
        
        switch snapShotGraphMode {
            
        case .appliedToControlPoint:
            print("[GRAPHTHIS] (snapShotGraphAttributeEntireGraph) We are trying to snap-shot, but already have snap-shot mode of \"appliedToControlPoint\"...")
        case .appliedToEntireGraph:
            print("[GRAPHTHIS] (snapShotGraphAttributeEntireGraph) We are trying to snap-shot, but already have snap-shot mode of \"appliedToEntireGraph\"...")
        case .invalid:
            break
        }
        
        if let selectedJiggle = selectedJiggle {
            if let selectedJiggleIndex = getJiggleIndex(selectedJiggle: selectedJiggle,
                                                        jiggles: jiggles,
                                                        jiggleCount: jiggleCount) {
                let snapShotGraphDataEntireGraph = readDataEntireGraph(jiggle: selectedJiggle,
                                                                       jiggleIndex: selectedJiggleIndex)
                snapShotGraphMode =  .appliedToEntireGraph(snapShotGraphDataEntireGraph)
                snapShotGraphIsGraphDrag = false
                return true
            } else {
                snapShotGraphMode = .invalid
                print("[GRAPHTHIS] (snapShotGraphAttributeAll) We are trying to snap-shot, but selected jiggle does not exist in list...")
                return false
            }
            
        } else {
            snapShotGraphMode = .invalid
            print("[GRAPHTHIS] (snapShotGraphAttributeAll) We are trying to snap-shot, but selected jiggle is null...")
            return false
        }
        
    }
    
    func readGraphControlPoint(jiggle: Jiggle,
                               graphIndex: Int) -> GraphAttributeDataControlPoint {
        
        let weightCurvePoint: WeightCurvePoint
        if graphIndex <= 0 {
            weightCurvePoint = jiggle.weightCurvePointStart
        } else if graphIndex == 1 {
            weightCurvePoint = jiggle.weightCurvePointMiddle
        } else {
            weightCurvePoint = jiggle.weightCurvePointEnd
        }
        
        let normalizedHeightFactor = weightCurvePoint.normalizedHeightFactor
        let isManualHeightEnabled = weightCurvePoint.isManualHeightEnabled
        let normalizedTanDirection = weightCurvePoint.normalizedTanDirection
        let normalizedTanMagnitudeIn = weightCurvePoint.normalizedTanMagnitudeIn
        let normalizedTanMagnitudeOut = weightCurvePoint.normalizedTanMagnitudeOut
        let isManualTanHandleEnabled = weightCurvePoint.isManualTanHandleEnabled
        
        return GraphAttributeDataControlPoint(normalizedHeightFactor: normalizedHeightFactor,
                                              isManualHeightEnabled: isManualHeightEnabled,
                                              normalizedTanDirection: normalizedTanDirection,
                                              normalizedTanMagnitudeIn: normalizedTanMagnitudeIn,
                                              normalizedTanMagnitudeOut: normalizedTanMagnitudeOut,
                                              isManualTanHandleEnabled: isManualTanHandleEnabled)
    }
    
    func readGraphPosition(jiggle: Jiggle,
                           graphIndex: Int) -> GraphAttributeDataHeight {
        
        let weightCurvePoint: WeightCurvePoint
        if graphIndex <= 0 {
            weightCurvePoint = jiggle.weightCurvePointStart
        } else if graphIndex == 1 {
            weightCurvePoint = jiggle.weightCurvePointMiddle
        } else {
            weightCurvePoint = jiggle.weightCurvePointEnd
        }
        
        let normalizedHeightFactor = weightCurvePoint.normalizedHeightFactor
        let isManualHeightEnabled = weightCurvePoint.isManualHeightEnabled
        
        return GraphAttributeDataHeight(normalizedHeightFactor: normalizedHeightFactor,
                                        isManualHeightEnabled: isManualHeightEnabled)
    }
    
    func readGraphTanHandles(jiggle: Jiggle,
                             graphIndex: Int) -> GraphAttributeDataTanHandles {
        
        let weightCurvePoint: WeightCurvePoint
        if graphIndex <= 0 {
            weightCurvePoint = jiggle.weightCurvePointStart
        } else if graphIndex == 1 {
            weightCurvePoint = jiggle.weightCurvePointMiddle
        } else {
            weightCurvePoint = jiggle.weightCurvePointEnd
        }
        let normalizedTanDirection = weightCurvePoint.normalizedTanDirection
        let normalizedTanMagnitudeIn = weightCurvePoint.normalizedTanMagnitudeIn
        let normalizedTanMagnitudeOut = weightCurvePoint.normalizedTanMagnitudeOut
        let isManualTanHandleEnabled = weightCurvePoint.isManualTanHandleEnabled
        return GraphAttributeDataTanHandles(normalizedTanDirection: normalizedTanDirection,
                                            normalizedTanMagnitudeIn: normalizedTanMagnitudeIn,
                                            normalizedTanMagnitudeOut: normalizedTanMagnitudeOut,
                                            isManualTanHandleEnabled: isManualTanHandleEnabled)
    }
    
    func readDataEntireGraph(jiggle: Jiggle,
                             jiggleIndex: Int) -> SnapShotGraphDataEntireGraph {
        
        let weightCurvePointStart = readGraphControlPoint(jiggle: jiggle,
                                                          graphIndex: 0)
        let weightCurvePointMiddle = readGraphControlPoint(jiggle: jiggle,
                                                           graphIndex: 1)
        let weightCurvePointEnd = readGraphControlPoint(jiggle: jiggle,
                                                        graphIndex: 2)
        let resetType = jiggle.weightCurve.resetType
        return SnapShotGraphDataEntireGraph(selectedJiggleIndex: jiggleIndex,
                                            weightCurvePointStart: weightCurvePointStart,
                                            weightCurvePointMiddle: weightCurvePointMiddle,
                                            weightCurvePointEnd: weightCurvePointEnd,
                                            resetType: resetType)
    }
    
    func readAttributeGraphControlPoint(jiggle: Jiggle,
                                        jiggleIndex: Int,
                                        graphIndex: Int,
                                        attributeType: GraphAttributeType) -> GraphAttribute {
        
        let graphAttributeTypeWithData: GraphAttributeTypeWithData
        switch attributeType {
        case .position:
            let graphAttributeDataHeight = readGraphPosition(jiggle: jiggle,
                                                             graphIndex: graphIndex)
            graphAttributeTypeWithData = .position(graphAttributeDataHeight)
        case .tanHandles:
            let graphAttributeDataTanHandles = readGraphTanHandles(jiggle: jiggle,
                                                                   graphIndex: graphIndex)
            graphAttributeTypeWithData = .tanHandles(graphAttributeDataTanHandles)
        }
        
        let result = GraphAttribute(jiggleIndex: jiggleIndex,
                                    graphIndex: graphIndex,
                                    grabAttributeType: attributeType,
                                    grabAttributeTypeWithData: graphAttributeTypeWithData)
        return result
    }
    
    
    /*
     private func writeAttributeTimeLineSwatch(animationWad: AnimationWad,
     swatch: Swatch,
     timeLineSwatchData: GraphAttributeDataTimeLineSwatch) {
     let timeLineSwatch = animationWad.timeLine.getSwatch(swatch: swatch)
     var channelIndex = 0
     for _ in TimeLine.minimumPointsPerChannel...TimeLine.maximumPointsPerChannel {
     let timeLineChannel = timeLineSwatch.channels[channelIndex]
     let channelData = timeLineSwatchData.channelDataList[channelIndex]
     
     let controlPointCount = min(timeLineChannel.controlPointCount, channelData.normalizedX.count)
     for controlPointIndex in 0..<controlPointCount {
     let controlPoint = timeLineChannel.controlPoints[controlPointIndex]
     controlPoint.normalizedTanDirection = channelData.normalizedTanDirection[controlPointIndex]
     controlPoint.normalizedTanMagnitudeIn = channelData.normalizedTanMagnitudeIn[controlPointIndex]
     controlPoint.normalizedTanMagnitudeOut = channelData.normalizedTanMagnitudeOut[controlPointIndex]
     controlPoint.normalizedX = channelData.normalizedX[controlPointIndex]
     controlPoint.normalizedY = channelData.normalizedY[controlPointIndex]
     controlPoint.isManualPositionEnabled = channelData.isManualPositionEnabled[controlPointIndex]
     controlPoint.isManualTanHandleEnabled = channelData.isManualTanHandleEnabled[controlPointIndex]
     }
     
     channelIndex += 1
     }
     
     timeLineSwatch.frameOffset = timeLineSwatchData.frameOffset
     
     if timeLineSwatchData.selectedChannelIndex >= 0 && timeLineSwatchData.selectedChannelIndex < timeLineSwatch.channelCount {
     timeLineSwatch.selectedChannelIndex = timeLineSwatchData.selectedChannelIndex
     timeLineSwatch.selectedChannel = timeLineSwatch.channels[timeLineSwatch.selectedChannelIndex]
     }
     }
     
     private func writeAttributeTimeLine(animationWad: AnimationWad,
     timeLineData: GraphAttributeDataTimeLine) {
     writeAttributeTimeLineSwatch(animationWad: animationWad, swatch: .x, timeLineSwatchData: timeLineData.swatchDataX)
     writeAttributeTimeLineSwatch(animationWad: animationWad, swatch: .y, timeLineSwatchData: timeLineData.swatchDataY)
     writeAttributeTimeLineSwatch(animationWad: animationWad, swatch: .scale, timeLineSwatchData: timeLineData.swatchDataScale)
     writeAttributeTimeLineSwatch(animationWad: animationWad, swatch: .rotation, timeLineSwatchData: timeLineData.swatchDataRotation)
     animationWad.timeLine.animationDuration = timeLineData.duration
     }
     
     func readAttributeFromAnimationWad(animationWad: AnimationWad,
     jiggleIndex: Int,
     attributeType: GraphAttributeType,
     selectedTimeLineSwatch: Swatch) -> GraphAttribute {
     
     switch attributeType {
     case .timeLine:
     let readData = readAttributeTimeLine(animationWad: animationWad,
     selectedTimeLineSwatch: selectedTimeLineSwatch)
     return GraphAttribute(jiggleIndex: jiggleIndex,
     loopAttributeType: attributeType,
     loopAttributeTypeWithData: .timeLine(readData))
     case .timeLineSwatchX:
     let readData = readAttributeTimeLineSwatch(animationWad: animationWad,
     swatch: .x,
     selectedTimeLineSwatch: selectedTimeLineSwatch)
     return GraphAttribute(jiggleIndex: jiggleIndex,
     loopAttributeType: attributeType,
     loopAttributeTypeWithData: .timeLineSwatchX(readData))
     case .timeLineSwatchY:
     let readData = readAttributeTimeLineSwatch(animationWad: animationWad,
     swatch: .y,
     selectedTimeLineSwatch: selectedTimeLineSwatch)
     return GraphAttribute(jiggleIndex: jiggleIndex,
     loopAttributeType: attributeType,
     loopAttributeTypeWithData: .timeLineSwatchY(readData))
     case .timeLineSwatchScale:
     let readData = readAttributeTimeLineSwatch(animationWad: animationWad,
     swatch: .scale,
     selectedTimeLineSwatch: selectedTimeLineSwatch)
     return GraphAttribute(jiggleIndex: jiggleIndex,
     loopAttributeType: attributeType,
     loopAttributeTypeWithData: .timeLineSwatchScale(readData))
     case .timeLineSwatchRotation:
     let readData = readAttributeTimeLineSwatch(animationWad: animationWad,
     swatch: .rotation,
     selectedTimeLineSwatch: selectedTimeLineSwatch)
     return GraphAttribute(jiggleIndex: jiggleIndex,
     loopAttributeType: attributeType,
     loopAttributeTypeWithData: .timeLineSwatchRotation(readData))
     case .timeLineFrameOffset:
     let currentSwatch = animationWad.timeLine.getSwatch(swatch: selectedTimeLineSwatch)
     let readData = GraphAttributeDataTimeLineFrameOffset(frameOffset: currentSwatch.frameOffset,
     selectedSwatch: selectedTimeLineSwatch)
     return GraphAttribute(jiggleIndex: jiggleIndex,
     loopAttributeType: .timeLineFrameOffset,
     loopAttributeTypeWithData: .timeLineFrameOffset(readData))
     case .timeLineDuration:
     let readData = GraphAttributeDataTimeLineDuration(duration: animationWad.timeLine.animationDuration,
     selectedSwatch: selectedTimeLineSwatch)
     return GraphAttribute(jiggleIndex: jiggleIndex,
     loopAttributeType: .timeLineDuration,
     loopAttributeTypeWithData: .timeLineDuration(readData))
     }
     }
     
     func restoreFromAttribute(animationWad: AnimationWad,
     loopAttribute: GraphAttribute) {
     
     switch loopAttribute.loopAttributeTypeWithData {
     case .timeLine(let timeLineData):
     writeAttributeTimeLine(animationWad: animationWad,
     timeLineData: timeLineData)
     case .timeLineSwatchX(let timeLineSwatchData):
     writeAttributeTimeLineSwatch(animationWad: animationWad,
     swatch: .x,
     timeLineSwatchData: timeLineSwatchData)
     case .timeLineSwatchY(let timeLineSwatchData):
     writeAttributeTimeLineSwatch(animationWad: animationWad,
     swatch: .y,
     timeLineSwatchData: timeLineSwatchData)
     case .timeLineSwatchScale(let timeLineSwatchData):
     writeAttributeTimeLineSwatch(animationWad: animationWad,
     swatch: .scale,
     timeLineSwatchData: timeLineSwatchData)
     case .timeLineSwatchRotation(let timeLineSwatchData):
     writeAttributeTimeLineSwatch(animationWad: animationWad,
     swatch: .rotation,
     timeLineSwatchData: timeLineSwatchData)
     case .timeLineFrameOffset(let timeLineFrameOffsetData):
     let selectedSwatch = animationWad.timeLine.getSelectedSwatch(swatch: timeLineFrameOffsetData.selectedSwatch)
     selectedSwatch.frameOffset = timeLineFrameOffsetData.frameOffset
     case .timeLineDuration(let timeLineDurationData):
     animationWad.timeLine.animationDuration = timeLineDurationData.duration
     }
     
     }
     
     */
}
