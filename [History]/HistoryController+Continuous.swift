//
//  __HistoryController+Continuous.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/18/25.
//

import Foundation

public extension HistoryController {
    
    func snapShotContinuousAttributeOne(attributeType: ContinuousAttributeType,
                                        targetJiggleIndex: Int?,
                                        jiggles: [Jiggle],
                                        jiggleCount: Int) {
        snapShotContinuousAttributeIsAppliedToAll = false
        if let targetJiggleIndex = targetJiggleIndex {
            if targetJiggleIndex >= 0 && targetJiggleIndex < jiggleCount {
                let jiggle = jiggles[targetJiggleIndex]
                let animationWad = jiggle.animationWad
                snapShotContinuousAttributeOneTargetIndex = targetJiggleIndex
                snapShotContinuousAttributeOne = readAttributeFromAnimationWad(animationWad: animationWad,
                                                                               jiggleIndex: targetJiggleIndex,
                                                                               attributeType: attributeType)
            }
        } else {
            snapShotContinuousAttributeOne = nil
        }
    }
    
    func snapShotContinuousAttributesAll(attributeType: ContinuousAttributeType,
                                         selectedJiggleIndex: Int?,
                                         jiggles: [Jiggle],
                                         jiggleCount: Int) {
        
        snapShotContinuousAttributeIsAppliedToAll = true
        
        if let selectedJiggleIndex = selectedJiggleIndex {
            
            if selectedJiggleIndex >= 0 && selectedJiggleIndex < jiggleCount {
                snapShotContinuousAttributesAllSelectedIndex = selectedJiggleIndex
                
                snapShotContinuousAttributesAll.removeAll(keepingCapacity: true)
                for jiggleIndex in 0..<jiggleCount {
                    let jiggle = jiggles[jiggleIndex]
                    let animationWad = jiggle.animationWad
                    let attribute = readAttributeFromAnimationWad(animationWad: animationWad,
                                                                  jiggleIndex: jiggleIndex,
                                                                  attributeType: attributeType)
                    snapShotContinuousAttributesAll.append(attribute)
                }
            } else {
                snapShotContinuousAttributesAll = []
            }
        } else {
            snapShotContinuousAttributesAll = []
        }
        
        snapShotContinuousAttributeIsAppliedToAll = true
    }
    
    func readAttributeFromAnimationWad(animationWad: AnimationWad,
                                       jiggleIndex: Int,
                                       attributeType: ContinuousAttributeType) -> ContinuousAttribute {
        switch attributeType {
        case .continuousAll:
            let readData = ContinuousAttributeDataUserAll(duration: animationWad.continuousDuration,
                                                          angle: animationWad.continuousAngle,
                                                          power: animationWad.continuousPower,
                                                          swoop: animationWad.continuousSwoop,
                                                          frameOffset: animationWad.continuousFrameOffset,
                                                          startScale: animationWad.continuousStartScale,
                                                          endScale: animationWad.continuousEndScale,
                                                          startRotation: animationWad.continuousStartRotation,
                                                          endRotation: animationWad.continuousEndRotation)
            let continuousAttribute = ContinuousAttribute(jiggleIndex: jiggleIndex,
                                                          continuousAttributeType: attributeType,
                                                          continuousAttributeTypeWithData: .continuousAll(readData))
            return continuousAttribute
        case .continuousDurationGroup:
            let readData = ContinuousAttributeDataUserDurationGroup(duration: animationWad.continuousDuration,
                                                                    angle: animationWad.continuousAngle,
                                                                    power: animationWad.continuousPower)
            let continuousAttribute = ContinuousAttribute(jiggleIndex: jiggleIndex,
                                                          continuousAttributeType: attributeType,
                                                          continuousAttributeTypeWithData: .continuousDurationGroup(readData))
            return continuousAttribute
        case .continuousScaleGroup:
            let readData = ContinuousAttributeDataUserScaleGroup(startScale: animationWad.continuousStartScale,
                                                                 endScale: animationWad.continuousEndScale,
                                                                 frameOffset: animationWad.continuousFrameOffset)
            let continuousAttribute = ContinuousAttribute(jiggleIndex: jiggleIndex,
                                                          continuousAttributeType: attributeType,
                                                          continuousAttributeTypeWithData: .continuousScaleGroup(readData))
            return continuousAttribute
        case .continuousRotationGroup:
            let readData = ContinuousAttributeDataUserRotationGroup(swoop: animationWad.continuousSwoop,
                                                                    startRotation: animationWad.continuousStartRotation,
                                                                    endRotation: animationWad.continuousEndRotation)
            let continuousAttribute = ContinuousAttribute(jiggleIndex: jiggleIndex,
                                                          continuousAttributeType: attributeType,
                                                          continuousAttributeTypeWithData: .continuousRotationGroup(readData))
            return continuousAttribute
        case .continuousDuration:
            return ContinuousAttribute(jiggleIndex: jiggleIndex,
                                       continuousAttributeType: attributeType,
                                       continuousAttributeTypeWithData: .continuousDuration(animationWad.continuousDuration))
        case .continuousFrameOffset:
            return ContinuousAttribute(jiggleIndex: jiggleIndex,
                                       continuousAttributeType: attributeType,
                                       continuousAttributeTypeWithData: .continuousFrameOffset(animationWad.continuousFrameOffset))
        case .continuousAngle:
            return ContinuousAttribute(jiggleIndex: jiggleIndex,
                                       continuousAttributeType: attributeType,
                                       continuousAttributeTypeWithData: .continuousAngle(animationWad.continuousAngle))
        case .continuousPower:
            return ContinuousAttribute(jiggleIndex: jiggleIndex,
                                       continuousAttributeType: attributeType,
                                       continuousAttributeTypeWithData: .continuousPower(animationWad.continuousPower))
            
        case .continuousSwoop:
            return ContinuousAttribute(jiggleIndex: jiggleIndex,
                                       continuousAttributeType: attributeType,
                                       continuousAttributeTypeWithData: .continuousSwoop(animationWad.continuousSwoop))
            
        case .continuousStartScale:
            return ContinuousAttribute(jiggleIndex: jiggleIndex,
                                       continuousAttributeType: attributeType,
                                       continuousAttributeTypeWithData: .continuousStartScale(animationWad.continuousStartScale))
        case .continuousEndScale:
            return ContinuousAttribute(jiggleIndex: jiggleIndex,
                                       continuousAttributeType: attributeType,
                                       continuousAttributeTypeWithData: .continuousEndScale(animationWad.continuousEndScale))
            
        case .continuousStartRotation:
            return ContinuousAttribute(jiggleIndex: jiggleIndex,
                                       continuousAttributeType: attributeType,
                                       continuousAttributeTypeWithData: .continuousStartRotation(animationWad.continuousStartRotation))
        case .continuousEndRotation:
            return ContinuousAttribute(jiggleIndex: jiggleIndex,
                                       continuousAttributeType: attributeType,
                                       continuousAttributeTypeWithData: .continuousEndRotation(animationWad.continuousEndRotation))
            
        }
    }
    
    func restoreFromAttribute(animationWad: AnimationWad,
                              continuousAttribute: ContinuousAttribute) {
        switch continuousAttribute.continuousAttributeTypeWithData {
        case .continuousAll(let userAllData):
            animationWad.continuousDuration = userAllData.duration
            animationWad.continuousAngle = userAllData.angle
            animationWad.continuousPower = userAllData.power
            animationWad.continuousSwoop = userAllData.swoop
            animationWad.continuousFrameOffset = userAllData.frameOffset
            animationWad.continuousStartScale = userAllData.startScale
            animationWad.continuousEndScale = userAllData.endScale
            animationWad.continuousStartRotation = userAllData.startRotation
            animationWad.continuousEndRotation = userAllData.endRotation
        case .continuousDurationGroup(let userDurationGroupData):
            animationWad.continuousDuration = userDurationGroupData.duration
            animationWad.continuousAngle = userDurationGroupData.angle
            animationWad.continuousPower = userDurationGroupData.power
        case .continuousScaleGroup(let userScaleGroupData):
            animationWad.continuousStartScale = userScaleGroupData.startScale
            animationWad.continuousEndScale = userScaleGroupData.endScale
            animationWad.continuousFrameOffset = userScaleGroupData.frameOffset
        case .continuousRotationGroup(let userRotationGroupData):
            animationWad.continuousSwoop = userRotationGroupData.swoop
            animationWad.continuousStartRotation = userRotationGroupData.startRotation
            animationWad.continuousEndRotation = userRotationGroupData.endRotation
        case .continuousDuration(let durationData):
            animationWad.continuousDuration = durationData
        case .continuousFrameOffset(let frameOffsetData):
            animationWad.continuousFrameOffset = frameOffsetData
        case .continuousAngle(let angleData):
            animationWad.continuousAngle = angleData
        case .continuousPower(let powerData):
            animationWad.continuousPower = powerData
        case .continuousSwoop(let swoopData):
            animationWad.continuousSwoop = swoopData
        case .continuousStartScale(let startScaleData):
            animationWad.continuousStartScale = startScaleData
        case .continuousEndScale(let endScaleData):
            animationWad.continuousEndScale = endScaleData
        case .continuousStartRotation(let startRotationData):
            animationWad.continuousStartRotation = startRotationData
        case .continuousEndRotation(let endRotationData):
            animationWad.continuousEndRotation = endRotationData
        }
    }
    
}
