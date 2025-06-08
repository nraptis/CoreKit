//
//  __HistoryController+Continuous.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/18/25.
//

import Foundation

public extension HistoryController {
    
    func snapShotContinuousReset() {
        snapShotContinuousMode = .invalid
        snapShotContinuousInterfaceElement = HistoryController.invalidInterfaceElement
    }
    
    func snapShotContinuousAttributeOne(attributeType: ContinuousAttributeType,
                                        selectedJiggle: Jiggle?,
                                        jiggles: [Jiggle],
                                        jiggleCount: Int,
                                        interfaceElement: UInt16,
                                        mirrorEnabled: Bool,
                                        mirrorElementType: MirrorElementType) -> Bool {
        
        if snapShotContinuousInterfaceElement != HistoryController.invalidInterfaceElement {
            print("[CONTHIS] (snapShotContinuousAttributeOne) We are trying to snap-shot an interface element, but \(snapShotContinuousInterfaceElement) is already active...")
            return false
        }
        
        switch snapShotContinuousMode {
        case .appliedToSelected:
            print("[CONTHIS] (snapShotContinuousAttributeOne) We are trying to snap-shot, but already have snap-shot mode of \"appliedToSelected\"...")
            return false
        case .appliedToAll(_):
            print("[CONTHIS] (snapShotContinuousAttributeOne) We are trying to snap-shot, but already have snap-shot mode of \"appliedToAll\"...")
            return false
        case .invalid:
            break
        }
        
        if let selectedJiggle = selectedJiggle {
            if let selectedJiggleIndex = getJiggleIndex(selectedJiggle: selectedJiggle,
                                                        jiggles: jiggles,
                                                        jiggleCount: jiggleCount) {
                
                let selectedAnimationWad = selectedJiggle.animationWad
                let selectedJiggleAttribute = readAttributeFromAnimationWad(animationWad: selectedAnimationWad,
                                                                            jiggleIndex: selectedJiggleIndex,
                                                                            attributeType: attributeType)
                let snapShotContinuousOneData = SnapShotContinuousOneData(selectedJiggleIndex: selectedJiggleIndex,
                                                                          selectedJiggleAttribute: selectedJiggleAttribute,
                                                                          mirrorEnabled: mirrorEnabled,
                                                                          mirrorElementType: mirrorElementType)
                
                snapShotContinuousMode = .appliedToSelected(snapShotContinuousOneData)
                snapShotContinuousInterfaceElement = interfaceElement
                return true
                
            } else {
                snapShotContinuousMode = .invalid
                print("[CONTHIS] (snapShotContinuousAttributeOne) We are trying to snap-shot, but selected jiggle does not exist in list...")
                return false
            }
            
        } else {
            snapShotContinuousMode = .invalid
            print("[CONTHIS] (snapShotContinuousAttributeOne) We are trying to snap-shot, but selected jiggle is null...")
            return false
        }
        
    }
    
    func snapShotContinuousAttributeAll(attributeType: ContinuousAttributeType,
                                         selectedJiggle: Jiggle?,
                                         jiggles: [Jiggle],
                                         jiggleCount: Int,
                                         interfaceElement: UInt16,
                                         mirrorEnabled: Bool,
                                         mirrorElementType: MirrorElementType) -> Bool {
        
        if snapShotContinuousInterfaceElement != HistoryController.invalidInterfaceElement {
            print("[CONTHIS] (snapShotContinuousAttributeAll) We are trying to snap-shot an interface element, but \(snapShotContinuousInterfaceElement) is already active...")
            return false
        }
        
        switch snapShotContinuousMode {
            
        case .appliedToSelected:
            print("[CONTHIS] (snapShotContinuousAttributeAll) We are trying to snap-shot, but already have snap-shot mode of \"appliedToSelected\"...")
            return false
        case .appliedToAll(_):
            print("[CONTHIS] (snapShotContinuousAttributeAll) We are trying to snap-shot, but already have snap-shot mode of \"appliedToAll\"...")
            return false
        case .invalid:
            break
        }
        
        
        if let selectedJiggle = selectedJiggle {
            if let selectedJiggleIndex = getJiggleIndex(selectedJiggle: selectedJiggle,
                                                        jiggles: jiggles,
                                                        jiggleCount: jiggleCount) {
                
                let selectedAnimationWad = selectedJiggle.animationWad
                let selectedJiggleAttribute = readAttributeFromAnimationWad(animationWad: selectedAnimationWad,
                                                                            jiggleIndex: selectedJiggleIndex,
                                                                            attributeType: attributeType)
                
                var otherJiggleIndices = [Int]()
                var otherJiggleAttributes = [ContinuousAttribute]()
                for otherJiggleIndex in 0..<jiggleCount {
                    if otherJiggleIndex != selectedJiggleIndex {
                        let otherJiggle = jiggles[otherJiggleIndex]
                        let otherAnimationWad = otherJiggle.animationWad
                        let otherJiggleAttribute = readAttributeFromAnimationWad(animationWad: otherAnimationWad,
                                                                                 jiggleIndex: otherJiggleIndex,
                                                                                 attributeType: attributeType)
                        otherJiggleIndices.append(otherJiggleIndex)
                        otherJiggleAttributes.append(otherJiggleAttribute)
                    }
                    
                }
                
                let snapShotContinuousAllData = SnapShotContinuousAllData(selectedJiggleIndex: selectedJiggleIndex,
                                                     selectedJiggleAttribute: selectedJiggleAttribute,
                                                     otherJiggleIndices: otherJiggleIndices,
                                                     otherJiggleAttributes: otherJiggleAttributes,
                                                     mirrorEnabled: mirrorEnabled,
                                                     mirrorElementType: mirrorElementType)
                
                
                snapShotContinuousMode = .appliedToAll(snapShotContinuousAllData)
                snapShotContinuousInterfaceElement = interfaceElement
                return true
            } else {
                snapShotContinuousMode = .invalid
                print("[CONTHIS] (snapShotContinuousAttributeAll) We are trying to snap-shot, but selected jiggle does not exist in list...")
                return false
            }
            
        } else {
            snapShotContinuousMode = .invalid
            print("[CONTHIS] (snapShotContinuousAttributeAll) We are trying to snap-shot, but selected jiggle is null...")
            return false
        }
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
                                                          wiggle: animationWad.continuousWiggle,
                                                          frameOffset: animationWad.continuousFrameOffset,
                                                          startScale: animationWad.continuousStartScale,
                                                          endScale: animationWad.continuousEndScale,
                                                          startRotation: animationWad.continuousStartRotation,
                                                          endRotation: animationWad.continuousEndRotation)
            let continuousAttribute = ContinuousAttribute(jiggleIndex: jiggleIndex,
                                                          continuousAttributeType: attributeType,
                                                          continuousAttributeTypeWithData: .continuousAll(readData))
            return continuousAttribute
        case .continuousGroup1:
            let readData = ContinuousAttributeDataUserGroup1(duration: animationWad.continuousDuration,
                                                             power: animationWad.continuousPower)
            let continuousAttribute = ContinuousAttribute(jiggleIndex: jiggleIndex,
                                                          continuousAttributeType: attributeType,
                                                          continuousAttributeTypeWithData: .continuousGroup1(readData))
            return continuousAttribute
        case .continuousGroup2:
            let readData = ContinuousAttributeDataUserGroup2(angle: animationWad.continuousAngle,
                                                             swoop: animationWad.continuousSwoop)
            let continuousAttribute = ContinuousAttribute(jiggleIndex: jiggleIndex,
                                                          continuousAttributeType: attributeType,
                                                          continuousAttributeTypeWithData: .continuousGroup2(readData))
            return continuousAttribute
        case .continuousGroup3:
            let readData = ContinuousAttributeDataUserGroup3(startRotation: animationWad.continuousStartRotation,
                                                             endRotation: animationWad.continuousEndRotation)
            let continuousAttribute = ContinuousAttribute(jiggleIndex: jiggleIndex,
                                                          continuousAttributeType: attributeType,
                                                          continuousAttributeTypeWithData: .continuousGroup3(readData))
            return continuousAttribute
        case .continuousGroup4:
            let readData = ContinuousAttributeDataUserGroup4(startScale: animationWad.continuousStartScale,
                                                             endScale: animationWad.continuousEndScale)
            let continuousAttribute = ContinuousAttribute(jiggleIndex: jiggleIndex,
                                                          continuousAttributeType: attributeType,
                                                          continuousAttributeTypeWithData: .continuousGroup4(readData))
            return continuousAttribute
        case .continuousGroup5:
            let readData = ContinuousAttributeDataUserGroup5(wiggle: animationWad.continuousWiggle,
                                                             frameOffset: animationWad.continuousFrameOffset)
            let continuousAttribute = ContinuousAttribute(jiggleIndex: jiggleIndex,
                                                          continuousAttributeType: attributeType,
                                                          continuousAttributeTypeWithData: .continuousGroup5(readData))
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
        case .continuousWiggle:
            return ContinuousAttribute(jiggleIndex: jiggleIndex,
                                       continuousAttributeType: attributeType,
                                       continuousAttributeTypeWithData: .continuousWiggle(animationWad.continuousWiggle))
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
            //p1
            animationWad.continuousDuration = userAllData.duration
            animationWad.continuousPower = userAllData.power
            
            //p2
            animationWad.continuousAngle = userAllData.angle
            animationWad.continuousSwoop = userAllData.swoop
            
            //p3
            animationWad.continuousStartRotation = userAllData.startRotation
            animationWad.continuousEndRotation = userAllData.endRotation
            
            //p4
            animationWad.continuousStartScale = userAllData.startScale
            animationWad.continuousEndScale = userAllData.endScale
            
            //p5
            animationWad.continuousWiggle = userAllData.wiggle
            animationWad.continuousFrameOffset = userAllData.frameOffset
            
        case .continuousGroup1(let userGroup1Data):
            animationWad.continuousDuration = userGroup1Data.duration
            animationWad.continuousPower = userGroup1Data.power
        case .continuousGroup2(let userGroup2Data):
            animationWad.continuousAngle = userGroup2Data.angle
            animationWad.continuousSwoop = userGroup2Data.swoop
        case .continuousGroup3(let userGroup3Data):
            animationWad.continuousStartRotation = userGroup3Data.startRotation
            animationWad.continuousEndRotation = userGroup3Data.endRotation
        case .continuousGroup4(let userGroup4Data):
            animationWad.continuousStartScale = userGroup4Data.startScale
            animationWad.continuousEndScale = userGroup4Data.endScale
        case .continuousGroup5(let userGroup5Data):
            animationWad.continuousWiggle = userGroup5Data.wiggle
            animationWad.continuousFrameOffset = userGroup5Data.frameOffset
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
        case .continuousWiggle(let wiggleData):
            animationWad.continuousWiggle = wiggleData
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
