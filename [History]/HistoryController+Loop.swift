//
//  __HistoryController+Loop.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/18/25.
//

import Foundation

public extension HistoryController {
    
    func snapShotLoopAttributeOne(attributeType: LoopAttributeType,
                                  targetJiggleIndex: Int?,
                                  selectedTimeLineSwatch: Swatch,
                                  jiggles: [Jiggle],
                                  jiggleCount: Int) {
        snapShotLoopAttributeIsAppliedToAll = false
        if let targetJiggleIndex = targetJiggleIndex {
            if targetJiggleIndex >= 0 && targetJiggleIndex < jiggleCount {
                let jiggle = jiggles[targetJiggleIndex]
                let animationWad = jiggle.animationWad
                snapShotLoopAttributeOneTargetIndex = targetJiggleIndex
                snapShotLoopAttributeOne = readAttributeFromAnimationWad(animationWad: animationWad,
                                                                   jiggleIndex: targetJiggleIndex,
                                                                   attributeType: attributeType,
                                                                   selectedTimeLineSwatch: selectedTimeLineSwatch)
            }
        } else {
            snapShotLoopAttributeOne = nil
        }
    }
    
    func snapShotLoopAttributesAll(attributeType: LoopAttributeType,
                                   selectedJiggleIndex: Int?,
                                   selectedTimeLineSwatch: Swatch,
                                   jiggles: [Jiggle],
                                   jiggleCount: Int) {
        
        snapShotLoopAttributeIsAppliedToAll = true
        
        if let selectedJiggleIndex = selectedJiggleIndex {
            
            if selectedJiggleIndex >= 0 && selectedJiggleIndex < jiggleCount {
                snapShotLoopAttributesAllSelectedIndex = selectedJiggleIndex
                
                snapShotLoopAttributesAll.removeAll(keepingCapacity: true)
                for jiggleIndex in 0..<jiggleCount {
                    let jiggle = jiggles[jiggleIndex]
                    let animationWad = jiggle.animationWad
                    
                    let attribute = readAttributeFromAnimationWad(animationWad: animationWad,
                                                            jiggleIndex: jiggleIndex,
                                                            attributeType: attributeType,
                                                            selectedTimeLineSwatch: selectedTimeLineSwatch)
                    snapShotLoopAttributesAll.append(attribute)
                }
            } else {
                snapShotLoopAttributesAll = []
            }
        } else {
            snapShotLoopAttributesAll = []
        }
        
        snapShotLoopAttributeIsAppliedToAll = true
    }
    
    private func readAttributeTimeLineSwatch(animationWad: AnimationWad,
                                             swatch: Swatch,
                                             selectedTimeLineSwatch: Swatch) -> LoopAttributeDataTimeLineSwatch {
        
        var channelDataList = [LoopAttributeDataTimeLineChannel]()
        let timeLineSwatch = animationWad.timeLine.getSwatch(swatch: swatch)
        var channelIndex = 0
        for _ in TimeLine.minimumPointsPerChannel...TimeLine.maximumPointsPerChannel {
            let timeLineChannel = timeLineSwatch.channels[channelIndex]
            let channelData = LoopAttributeDataTimeLineChannel(timeLineChannel: timeLineChannel)
            channelDataList.append(channelData)
            channelIndex += 1
        }
        return LoopAttributeDataTimeLineSwatch(swatch: swatch,
                                               selectedSwatch: selectedTimeLineSwatch,
                                               selectedChannelIndex: timeLineSwatch.selectedChannelIndex,
                                               frameOffset: timeLineSwatch.frameOffset,
                                               channelDataList: channelDataList)
    }
    
    private func readAttributeTimeLine(animationWad: AnimationWad,
                                       selectedTimeLineSwatch: Swatch) -> LoopAttributeDataTimeLine {
        let swatchDataX = readAttributeTimeLineSwatch(animationWad: animationWad, swatch: .x, selectedTimeLineSwatch: selectedTimeLineSwatch)
        let swatchDataY = readAttributeTimeLineSwatch(animationWad: animationWad, swatch: .y, selectedTimeLineSwatch: selectedTimeLineSwatch)
        let swatchDataScale = readAttributeTimeLineSwatch(animationWad: animationWad, swatch: .scale, selectedTimeLineSwatch: selectedTimeLineSwatch)
        let swatchDataRotation = readAttributeTimeLineSwatch(animationWad: animationWad, swatch: .rotation, selectedTimeLineSwatch: selectedTimeLineSwatch)
        return LoopAttributeDataTimeLine(swatchDataX: swatchDataX,
                                         swatchDataY: swatchDataY,
                                         swatchDataScale: swatchDataScale,
                                         swatchDataRotation: swatchDataRotation,
                                         duration: animationWad.timeLine.animationDuration)
    }
    
    private func writeAttributeTimeLineSwatch(animationWad: AnimationWad,
                                              swatch: Swatch,
                                              timeLineSwatchData: LoopAttributeDataTimeLineSwatch) {
        
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
                                        timeLineData: LoopAttributeDataTimeLine) {
        writeAttributeTimeLineSwatch(animationWad: animationWad, swatch: .x, timeLineSwatchData: timeLineData.swatchDataX)
        writeAttributeTimeLineSwatch(animationWad: animationWad, swatch: .y, timeLineSwatchData: timeLineData.swatchDataY)
        writeAttributeTimeLineSwatch(animationWad: animationWad, swatch: .scale, timeLineSwatchData: timeLineData.swatchDataScale)
        writeAttributeTimeLineSwatch(animationWad: animationWad, swatch: .rotation, timeLineSwatchData: timeLineData.swatchDataRotation)
        animationWad.timeLine.animationDuration = timeLineData.duration
    }
    
    func readAttributeFromAnimationWad(animationWad: AnimationWad,
                                 jiggleIndex: Int,
                                 attributeType: LoopAttributeType,
                                 selectedTimeLineSwatch: Swatch) -> LoopAttribute {
        
        switch attributeType {
        case .timeLine:
            let readData = readAttributeTimeLine(animationWad: animationWad,
                                                 selectedTimeLineSwatch: selectedTimeLineSwatch)
            return LoopAttribute(jiggleIndex: jiggleIndex,
                                 loopAttributeType: attributeType,
                                 loopAttributeTypeWithData: .timeLine(readData))
        case .timeLineSwatchX:
            let readData = readAttributeTimeLineSwatch(animationWad: animationWad,
                                                       swatch: .x,
                                                       selectedTimeLineSwatch: selectedTimeLineSwatch)
            return LoopAttribute(jiggleIndex: jiggleIndex,
                                 loopAttributeType: attributeType,
                                 loopAttributeTypeWithData: .timeLineSwatchX(readData))
        case .timeLineSwatchY:
            let readData = readAttributeTimeLineSwatch(animationWad: animationWad,
                                                       swatch: .y,
                                                       selectedTimeLineSwatch: selectedTimeLineSwatch)
            return LoopAttribute(jiggleIndex: jiggleIndex,
                                 loopAttributeType: attributeType,
                                 loopAttributeTypeWithData: .timeLineSwatchY(readData))
        case .timeLineSwatchScale:
            let readData = readAttributeTimeLineSwatch(animationWad: animationWad,
                                                       swatch: .scale,
                                                       selectedTimeLineSwatch: selectedTimeLineSwatch)
            return LoopAttribute(jiggleIndex: jiggleIndex,
                                 loopAttributeType: attributeType,
                                 loopAttributeTypeWithData: .timeLineSwatchScale(readData))
        case .timeLineSwatchRotation:
            let readData = readAttributeTimeLineSwatch(animationWad: animationWad,
                                                       swatch: .rotation,
                                                       selectedTimeLineSwatch: selectedTimeLineSwatch)
            return LoopAttribute(jiggleIndex: jiggleIndex,
                                 loopAttributeType: attributeType,
                                 loopAttributeTypeWithData: .timeLineSwatchRotation(readData))
        case .timeLineFrameOffset:
            let currentSwatch = animationWad.timeLine.getSwatch(swatch: selectedTimeLineSwatch)
            let readData = LoopAttributeDataTimeLineFrameOffset(frameOffset: currentSwatch.frameOffset,
                                                                selectedSwatch: selectedTimeLineSwatch)
            return LoopAttribute(jiggleIndex: jiggleIndex,
                                 loopAttributeType: .timeLineFrameOffset,
                                 loopAttributeTypeWithData: .timeLineFrameOffset(readData))
        case .timeLineDuration:
            let readData = LoopAttributeDataTimeLineDuration(duration: animationWad.timeLine.animationDuration,
                                                             selectedSwatch: selectedTimeLineSwatch)
            return LoopAttribute(jiggleIndex: jiggleIndex,
                                 loopAttributeType: .timeLineDuration,
                                 loopAttributeTypeWithData: .timeLineDuration(readData))
        }
    }
    
    func restoreFromAttribute(animationWad: AnimationWad,
                              loopAttribute: LoopAttribute) {
        
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
    
}
