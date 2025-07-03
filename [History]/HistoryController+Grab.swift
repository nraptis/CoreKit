//
//  __HistoryController+Grab.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/18/25.
//

import Foundation

public extension HistoryController {
    
    func snapShotGrabReset() {
        snapShotGrabMode = .invalid
        snapShotGrabInterfaceElement = HistoryController.invalidInterfaceElement
    }
    
    func snapShotGrabAttributeOne(attributeType: GrabAttributeType,
                                  selectedJiggle: Jiggle?,
                                  jiggles: [Jiggle],
                                  jiggleCount: Int,
                                  interfaceElement: UInt16) -> Bool {
        
        if snapShotGrabInterfaceElement != HistoryController.invalidInterfaceElement {
            return false
        }
        
        switch snapShotGrabMode {
        case .appliedToSelected:
            return false
        case .appliedToAll(_):
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
                let snapShotGrabOneData = SnapShotGrabOneData(selectedJiggleIndex: selectedJiggleIndex,
                                                              selectedJiggleAttribute: selectedJiggleAttribute)
                
                snapShotGrabMode = .appliedToSelected(snapShotGrabOneData)
                snapShotGrabInterfaceElement = interfaceElement
                return true
                
            } else {
                snapShotGrabMode = .invalid
                return false
            }
            
        } else {
            snapShotGrabMode = .invalid
            return false
        }
        
    }
    
    func snapShotGrabAttributeAll(attributeType: GrabAttributeType,
                                  selectedJiggle: Jiggle?,
                                  jiggles: [Jiggle],
                                  jiggleCount: Int,
                                  interfaceElement: UInt16) -> Bool {
        
        if snapShotGrabInterfaceElement != HistoryController.invalidInterfaceElement {
            return false
        }
        
        switch snapShotGrabMode {
            
        case .appliedToSelected:
            return false
        case .appliedToAll(_):
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
                var otherJiggleAttributes = [GrabAttribute]()
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
                
                let snapShotGrabAllData = SnapShotGrabAllData(selectedJiggleIndex: selectedJiggleIndex,
                                                              selectedJiggleAttribute: selectedJiggleAttribute,
                                                              otherJiggleIndices: otherJiggleIndices,
                                                              otherJiggleAttributes: otherJiggleAttributes)
                snapShotGrabMode = .appliedToAll(snapShotGrabAllData)
                snapShotGrabInterfaceElement = interfaceElement
                return true
            } else {
                snapShotGrabMode = .invalid
                print("[GRABTHIS] (snapShotGrabAttributeAll) We are trying to snap-shot, but selected jiggle does not exist in list...")
                return false
            }
            
        } else {
            snapShotGrabMode = .invalid
            print("[GRABTHIS] (snapShotGrabAttributeAll) We are trying to snap-shot, but selected jiggle is null...")
            return false
        }
    }
    
    func readAttributeFromAnimationWad(animationWad: AnimationWad,
                                       jiggleIndex: Int,
                                       attributeType: GrabAttributeType) -> GrabAttribute {
        switch attributeType {
        case .all:
            let grabAttributeDataUserAll = GrabAttributeDataUserAll(dragPower: animationWad.grabDragPower,
                                                                    speed: animationWad.grabSpeed,
                                                                    stiffness: animationWad.grabStiffness,
                                                                    gyroPower: animationWad.grabGyroPower)
            return GrabAttribute(jiggleIndex: jiggleIndex,
                                 grabAttributeType: attributeType,
                                 grabAttributeTypeWithData: .all(grabAttributeDataUserAll))
        case .grabDragPower:
            return GrabAttribute(jiggleIndex: jiggleIndex,
                                 grabAttributeType: attributeType,
                                 grabAttributeTypeWithData: .grabDragPower(animationWad.grabDragPower))
        case .grabSpeed:
            return GrabAttribute(jiggleIndex: jiggleIndex,
                                 grabAttributeType: attributeType,
                                 grabAttributeTypeWithData: .grabSpeed(animationWad.grabSpeed))
        case .grabStiffness:
            return GrabAttribute(jiggleIndex: jiggleIndex,
                                 grabAttributeType: attributeType,
                                 grabAttributeTypeWithData: .grabStiffness(animationWad.grabStiffness))
        case .grabGyroPower:
            return GrabAttribute(jiggleIndex: jiggleIndex,
                                 grabAttributeType: attributeType,
                                 grabAttributeTypeWithData: .grabGyroPower(animationWad.grabGyroPower))
        }
    }
    
    func restoreFromAttribute(animationWad: AnimationWad,
                              grabAttribute: GrabAttribute) {
        switch grabAttribute.grabAttributeTypeWithData {
        case .all(let grabData):
            animationWad.grabDragPower = grabData.dragPower
            animationWad.grabSpeed = grabData.speed
            animationWad.grabStiffness = grabData.stiffness
            animationWad.grabGyroPower = grabData.gyroPower
        case .grabDragPower(let grabDragPower):
            animationWad.grabDragPower = grabDragPower
        case .grabSpeed(let grabSpeed):
            animationWad.grabSpeed = grabSpeed
        case .grabStiffness(let grabStiffness):
            animationWad.grabStiffness = grabStiffness
        case .grabGyroPower(let grabGyroPower):
            animationWad.grabGyroPower = grabGyroPower
        }
    }
    
}
