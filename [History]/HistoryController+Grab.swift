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
                print("[GRABTHIS] (snapShotGrabAttributeOne) We are trying to snap-shot an interface element, but \(snapShotGrabInterfaceElement) is already active...")
                return false
            }
            
            switch snapShotGrabMode {
            case .appliedToSelected:
                print("[GRABTHIS] (snapShotGrabAttributeOne) We are trying to snap-shot, but already have snap-shot mode of \"appliedToSelected\"...")
                return false
            case .appliedToAll(_):
                print("[GRABTHIS] (snapShotGrabAttributeOne) We are trying to snap-shot, but already have snap-shot mode of \"appliedToAll\"...")
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
                    print("[GRABTHIS] (snapShotGrabAttributeOne) We are trying to snap-shot, but selected jiggle does not exist in list...")
                    return false
                }
                                                    
            } else {
                snapShotGrabMode = .invalid
                print("[GRABTHIS] (snapShotGrabAttributeOne) We are trying to snap-shot, but selected jiggle is null...")
                return false
            }
            
        }
        
        func snapShotGrabAttributeAll(attributeType: GrabAttributeType,
                                             selectedJiggle: Jiggle?,
                                             jiggles: [Jiggle],
                                             jiggleCount: Int,
                                             interfaceElement: UInt16) -> Bool {
            
            if snapShotGrabInterfaceElement != HistoryController.invalidInterfaceElement {
                print("[GRABTHIS] (snapShotGrabAttributeAll) We are trying to snap-shot an interface element, but \(snapShotGrabInterfaceElement) is already active...")
                return false
            }
            
            switch snapShotGrabMode {
                
            case .appliedToSelected:
                print("[GRABTHIS] (snapShotGrabAttributeAll) We are trying to snap-shot, but already have snap-shot mode of \"appliedToSelected\"...")
                return false
            case .appliedToAll(_):
                print("[GRABTHIS] (snapShotGrabAttributeAll) We are trying to snap-shot, but already have snap-shot mode of \"appliedToAll\"...")
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
                    print("[GRABTHIS], Successful Snapshot of MULTI")
                    print("[GRABTHIS], snapShotGrabMode = \(snapShotGrabMode)")
                    print("[GRABTHIS], snapShotGrabInterfaceElement = \(snapShotGrabInterfaceElement)")
                    
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
    
    /*
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
    
    func snapShotGrabAttributeAll(attributeType: GrabAttributeType,
                                   selectedJiggleIndex: Int?,
                                   jiggles: [Jiggle],
                                   jiggleCount: Int) {
        snapShotGrabAttributeIsAppliedToAll = true
        if let selectedJiggleIndex = selectedJiggleIndex {
            if selectedJiggleIndex >= 0 && selectedJiggleIndex < jiggleCount {
                snapShotGrabAttributeAllSelectedIndex = selectedJiggleIndex
                snapShotGrabAttributeAll.removeAll(keepingCapacity: true)
                for jiggleIndex in 0..<jiggleCount {
                    let jiggle = jiggles[jiggleIndex]
                    let animationWad = jiggle.animationWad
                    let attribute = readAttributeFromAnimationWad(animationWad: animationWad,
                                                                  jiggleIndex: jiggleIndex,
                                                                  attributeType: attributeType)
                    snapShotGrabAttributeAll.append(attribute)
                }
            } else {
                snapShotGrabAttributeAll = []
            }
        } else {
            snapShotGrabAttributeAll = []
        }
        snapShotGrabAttributeIsAppliedToAll = true
    }
    */
    
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
