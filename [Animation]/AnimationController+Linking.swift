//
//  AnimationController+Linking.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/19/24.
//

import Foundation

extension AnimationController {
    
    @MainActor func _linkAnimationTouches(jiggleDocument: AnimationControllerJiggleDocument,
                                          animationMode: AnimatonMode,
                                          displayMode: DisplayMode,
                                          touchTargetTouchSource: TouchTargetTouchSource,
                                          isPrecise: Bool) {
        
        switch animationMode {
        case .unknown:
            // [Touch Routes Verify] 12-7-2024
            // We will never link a touch for "unknown" animation mode.
            break
        case .grab:
            // [Touch Routes Verify] 12-7-2024
            // In the case that we are in grab mode...
            
            // We loop through all the touches...
            for animationTouchIndex in 0..<animationTouchCount {
                let animationTouch = animationTouches[animationTouchIndex]
                
                // If the touch is unassigned, we
                // attempt to link it to "grab" mode...
                switch animationTouch.residency {
                case .unassigned:
                    _ = _attemptLinkingTouchToJiggle_Grab(animationTouch: animationTouch,
                                                          jiggleDocument: jiggleDocument,
                                                          displayMode: displayMode,
                                                          touchTargetTouchSource: touchTargetTouchSource,
                                                          isPrecise: isPrecise)
                default:
                    break
                }
            }
            
        case .continuous:
            // [Touch Routes Verify] 12-7-2024
            // In the case that we are in continuous mode...
            
            // We loop through all the touches...
            for animationTouchIndex in 0..<animationTouchCount {
                let animationTouch = animationTouches[animationTouchIndex]
                
                // If the touch is unassigned, we
                // attempt to link it to "continuous" mode...
                switch animationTouch.residency {
                case .unassigned:
                    _ = _attemptLinkingTouchToJiggle_Continuous(animationTouch: animationTouch,
                                                                jiggleDocument: jiggleDocument,
                                                                displayMode: displayMode,
                                                                
                                                                touchTargetTouchSource: touchTargetTouchSource,
                                                                isPrecise: isPrecise)
                    
                default:
                    break
                }
            }
        case .loops:
            // [Touch Routes Verify] 12-7-2024
            // We will never link a touch for "loops" animation mode.
            break
        }
    }
    
    @MainActor private func _attemptLinkingTouchToJiggle_Grab(animationTouch: AnimationTouch,
                                                              jiggleDocument: AnimationControllerJiggleDocument,
                                                              displayMode: DisplayMode,
                                                              touchTargetTouchSource: TouchTargetTouchSource,
                                                              isPrecise: Bool) -> Bool {
        
        let selectJiggleCommand = SelectJiggleCommand(isJiggleCenterFirstPriority: false,
                                                      isFrozenIncluded: true)
        let selectJiggleResponse = jiggleDocument.getJiggleToSelect(points: [animationTouch.point],
                                                                    command: selectJiggleCommand,
                                                                    touchTargetTouchSource: touchTargetTouchSource)
        switch selectJiggleResponse {
        case .invalid:
            return false
        case .valid(let selectJiggleResponseData):
            let jiggleIndex = selectJiggleResponseData.jiggleIndex
            if let jiggle = jiggleDocument.getJiggleAnyObject(jiggleIndex) {
                animationTouch.linkToResidency(residency: .jiggleGrab(jiggle))
                jiggleDocument.switchSelectedJiggle(newSelectedJiggleIndex: jiggleIndex,
                                                    displayMode: displayMode,
                                                    isPrecise: isPrecise)
                return true
            } else {
                return false
            }
        }
    }
    
    @MainActor private func _attemptLinkingTouchToJiggle_Continuous(animationTouch: AnimationTouch,
                                                                    jiggleDocument: AnimationControllerJiggleDocument,
                                                                    displayMode: DisplayMode,
                                                                    touchTargetTouchSource: TouchTargetTouchSource,
                                                                    isPrecise: Bool) -> Bool {
        
        let selectJiggleCommand = SelectJiggleCommand(isJiggleCenterFirstPriority: false,
                                                      isFrozenIncluded: true)
        let selectJiggleResponse = jiggleDocument.getJiggleToSelect(points: [animationTouch.point],
                                                                    command: selectJiggleCommand,
                                                                    touchTargetTouchSource: touchTargetTouchSource)
        switch selectJiggleResponse {
        case .invalid:
            return false
        case .valid(let selectJiggleResponseData):
            let jiggleIndex = selectJiggleResponseData.jiggleIndex
            if let jiggle = jiggleDocument.getJiggleAnyObject(jiggleIndex) {
                animationTouch.linkToResidency(residency: .jiggleContinuous(jiggle))
                jiggleDocument.switchSelectedJiggle(newSelectedJiggleIndex: jiggleIndex,
                                                    displayMode: displayMode,
                                                    isPrecise: isPrecise)
                return true
            } else {
                return false
            }
        }
    }
    
}
