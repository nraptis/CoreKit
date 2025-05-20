//
//  __HistoryController+Grab.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/18/25.
//

import Foundation

public extension HistoryController {
    
    func snapShotGrabAttributeOne(attributeType: GrabAttributeType,
                                        targetJiggleIndex: Int?,
                                  jiggles: [Jiggle],
                                  jiggleCount: Int) {
        snapShotGrabAttributeIsAppliedToAll = false
        if let targetJiggleIndex = targetJiggleIndex {
            if targetJiggleIndex >= 0 && targetJiggleIndex < jiggleCount {
                let jiggle = jiggles[targetJiggleIndex]
                let animationWad = jiggle.animationWad
                snapShotGrabAttributeOneTargetIndex = targetJiggleIndex
                snapShotGrabAttributeOne = readAttributeFromAnimationWad(animationWad: animationWad,
                                                                         jiggleIndex: targetJiggleIndex,
                                                                         attributeType: attributeType)
            }
        } else {
            snapShotGrabAttributeOne = nil
        }
    }
    
    func snapShotGrabAttributesAll(attributeType: GrabAttributeType,
                                         selectedJiggleIndex: Int?,
                                   jiggles: [Jiggle],
                                   jiggleCount: Int) {
        
        snapShotGrabAttributeIsAppliedToAll = true
        
        if let selectedJiggleIndex = selectedJiggleIndex {
            
            if selectedJiggleIndex >= 0 && selectedJiggleIndex < jiggleCount {
                snapShotGrabAttributesAllSelectedIndex = selectedJiggleIndex
                
                snapShotGrabAttributesAll.removeAll(keepingCapacity: true)
                for jiggleIndex in 0..<jiggleCount {
                    let jiggle = jiggles[jiggleIndex]
                    let animationWad = jiggle.animationWad
                    let attribute = readAttributeFromAnimationWad(animationWad: animationWad,
                                                            jiggleIndex: jiggleIndex,
                                                            attributeType: attributeType)
                    snapShotGrabAttributesAll.append(attribute)
                }
            } else {
                snapShotGrabAttributesAll = []
            }
        } else {
            snapShotGrabAttributesAll = []
        }
        
        snapShotGrabAttributeIsAppliedToAll = true
    }
    
    func readAttributeFromAnimationWad(animationWad: AnimationWad,
                                 jiggleIndex: Int,
                                 attributeType: GrabAttributeType) -> GrabAttribute {
        
        switch attributeType {
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
