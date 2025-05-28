//
//  AnimationController+Touches.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/19/24.
//

import UIKit

extension AnimationController {
    
    @MainActor public func touchesBegan(jiggleViewModel: AnimationControllerJiggleViewModel,
                                        jiggleDocument: AnimationControllerJiggleDocument,
                                        jiggles: [Jiggle],
                                        jiggleCount: Int,
                                        animationMode: AnimatonMode,
                                        touches: [UITouch],
                                        points: [Math.Point],
                                        allTouchCount: Int,
                                        displayMode: DisplayMode,
                                        touchTargetTouchSource: TouchTargetTouchSource,
                                        isPrecise: Bool,
                                        isAnySliderActive: Bool,
                                        isContinuousDisableGrabEnabled: Bool,
                                        isAnimationContinuousAppliedToAll: Bool) {
        
        if checkSliderActiveAndFlushIfNeeded(jiggleViewModel: jiggleViewModel,
                                             jiggleDocument: jiggleDocument,
                                             jiggles: jiggles,
                                             jiggleCount: jiggleCount,
                                             animationMode: animationMode,
                                             isAnySliderActive: isAnySliderActive) {
            return
        }
        
        if checkContinuousDisabledAndFlushIfNeeded(jiggleViewModel: jiggleViewModel,
                                                   jiggleDocument: jiggleDocument,
                                                   jiggles: jiggles,
                                                   jiggleCount: jiggleCount,
                                                   animationMode: animationMode,
                                                   isContinuousDisableGrabEnabled: isContinuousDisableGrabEnabled) {
            let selectJiggleCommand = SelectJiggleCommand(isJiggleCenterFirstPriority: false,
                                                          isFrozenIncluded: true)
            _ = jiggleDocument.attemptSelectJiggle(points: points,
                                                   command: selectJiggleCommand,
                                                   nullifySelectionIfWhiff: false,
                                                   displayMode: displayMode,
                                                   touchTargetTouchSource: touchTargetTouchSource,
                                                   isPrecise: isPrecise)
            return
        }
        
        snapshot_pre(jiggles: jiggles,
                     jiggleCount: jiggleCount,
                     animationMode: animationMode)
        
        _flushAnimationTouches_TouchMatch(touches: touches)
        _flushPurgatoryAnimationTouches_TouchMatch(touches: touches)
        
        for touchIndex in 0..<touches.count {
            let touch = touches[touchIndex]
            let point = points[touchIndex]
            let animationTouch = AnimationPartsFactory.shared.withdrawAnimationTouch(touch: touch)
            animationTouch.x = point.x
            animationTouch.y = point.y
            animationTouchesAddUnique(animationTouch: animationTouch)
        }
        
        _linkAnimationTouches(jiggleDocument: jiggleDocument,
                              animationMode: animationMode,
                              displayMode: displayMode,
                              touchTargetTouchSource: touchTargetTouchSource,
                              isPrecise: isPrecise,
                              isAnimationContinuousAppliedToAll: isAnimationContinuousAppliedToAll)
        
        recordHistoryForTouches(touches: touches)
        
        snapshot_post(jiggleViewModel: jiggleViewModel,
                      jiggleDocument: jiggleDocument,
                      jiggles: jiggles,
                      jiggleCount: jiggleCount,
                      animationMode: animationMode)
        
        switch animationMode {
        case .loops:
            let selectJiggleCommand = SelectJiggleCommand(isJiggleCenterFirstPriority: false,
                                                          isFrozenIncluded: true)
            _ = jiggleDocument.attemptSelectJiggle(points: points,
                                                   command: selectJiggleCommand,
                                                   nullifySelectionIfWhiff: false,
                                                   displayMode: displayMode,
                                                   touchTargetTouchSource: touchTargetTouchSource,
                                                   isPrecise: isPrecise)
        default:
            break
        }
    }
    
    @MainActor public func touchesMoved(jiggleViewModel: AnimationControllerJiggleViewModel,
                                        jiggleDocument: AnimationControllerJiggleDocument,
                                        jiggles: [Jiggle],
                                        jiggleCount: Int,
                                        animationMode: AnimatonMode,
                                        touches: [UITouch],
                                        points: [Math.Point],
                                        allTouchCount: Int,
                                        displayMode: DisplayMode,
                                        touchTargetTouchSource: TouchTargetTouchSource,
                                        isPrecise: Bool,
                                        isAnySliderActive: Bool,
                                        isContinuousDisableGrabEnabled: Bool,
                                        isAnimationContinuousAppliedToAll: Bool) {
        
        if checkSliderActiveAndFlushIfNeeded(jiggleViewModel: jiggleViewModel,
                                             jiggleDocument: jiggleDocument,
                                             jiggles: jiggles,
                                             jiggleCount: jiggleCount,
                                             animationMode: animationMode,
                                             isAnySliderActive: isAnySliderActive) {
            return
        }
        
        if checkContinuousDisabledAndFlushIfNeeded(jiggleViewModel: jiggleViewModel,
                                                   jiggleDocument: jiggleDocument,
                                                   jiggles: jiggles,
                                                   jiggleCount: jiggleCount,
                                                   animationMode: animationMode,
                                                   isContinuousDisableGrabEnabled: isContinuousDisableGrabEnabled) {
            return
        }
        
        snapshot_pre(jiggles: jiggles,
                     jiggleCount: jiggleCount,
                     animationMode: animationMode)
        
        for touchIndex in 0..<touches.count {
            let touch = touches[touchIndex]
            let point = points[touchIndex]
            for animationTouchIndex in 0..<animationTouchCount {
                let animationTouch = animationTouches[animationTouchIndex]
                if animationTouch.touchID == ObjectIdentifier(touch) {
                    if (animationTouch.x != point.x) || (animationTouch.y != point.y) {
                        animationTouch.x = point.x
                        animationTouch.y = point.y
                        animationTouch.stationaryTime = 0.0
                    }
                }
            }
        }
        
        _linkAnimationTouches(jiggleDocument: jiggleDocument,
                              animationMode: animationMode,
                              displayMode: displayMode,
                              touchTargetTouchSource: touchTargetTouchSource,
                              isPrecise: isPrecise,
                              isAnimationContinuousAppliedToAll: isAnimationContinuousAppliedToAll)
        
        recordHistoryForTouches(touches: touches)
        
        snapshot_post(jiggleViewModel: jiggleViewModel,
                      jiggleDocument: jiggleDocument,
                      jiggles: jiggles,
                      jiggleCount: jiggleCount,
                      animationMode: animationMode)
    }
    
    @MainActor public func touchesEnded(jiggleViewModel: AnimationControllerJiggleViewModel,
                                        jiggleDocument: AnimationControllerJiggleDocument,
                                        jiggles: [Jiggle],
                                        jiggleCount: Int,
                                        animationMode: AnimatonMode,
                                        touches: [UITouch],
                                        points: [Math.Point],
                                        allTouchCount: Int,
                                        displayMode: DisplayMode,
                                        
                                        isAnySliderActive: Bool,
                                        isContinuousDisableGrabEnabled: Bool) {
        
        if checkSliderActiveAndFlushIfNeeded(jiggleViewModel: jiggleViewModel,
                                             jiggleDocument: jiggleDocument,
                                             jiggles: jiggles,
                                             jiggleCount: jiggleCount,
                                             animationMode: animationMode,
                                             isAnySliderActive: isAnySliderActive) {
            return
        }
        
        if checkContinuousDisabledAndFlushIfNeeded(jiggleViewModel: jiggleViewModel,
                                                   jiggleDocument: jiggleDocument,
                                                   jiggles: jiggles,
                                                   jiggleCount: jiggleCount,
                                                   animationMode: animationMode,
                                                   isContinuousDisableGrabEnabled: isContinuousDisableGrabEnabled) {
            return
        }
        
        snapshot_pre(jiggles: jiggles,
                     jiggleCount: jiggleCount,
                     animationMode: animationMode)
        
        tempAnimationTouchCount = 0
        for touchIndex in 0..<touches.count {
            let touch = touches[touchIndex]
            if let animationTouch = animationTouchesFind(touch: touch) {
                tempAnimationTouchesAddUnique(animationTouch)
            }
        }
        
        for animationTouchIndex in 0..<tempAnimationTouchCount {
            let animationTouch = tempAnimationTouches[animationTouchIndex]
            animationTouchesRemove(animationTouch: animationTouch)
        }
        
        snapshot_post(jiggleViewModel: jiggleViewModel,
                      jiggleDocument: jiggleDocument,
                      jiggles: jiggles,
                      jiggleCount: jiggleCount,
                      animationMode: animationMode)
        
    }
    
    @MainActor public func killDragAll(jiggleViewModel: AnimationControllerJiggleViewModel,
                                       jiggleDocument: AnimationControllerJiggleDocument,
                                       jiggles: [Jiggle],
                                       jiggleCount: Int,
                                       animationMode: AnimatonMode) {
        flushAll(jiggleViewModel: jiggleViewModel,
                 jiggleDocument: jiggleDocument,
                 jiggles: jiggles,
                 jiggleCount: jiggleCount,
                 animationMode: animationMode)
    }
    
    @MainActor private func checkContinuousDisabledAndFlushIfNeeded(jiggleViewModel: AnimationControllerJiggleViewModel,
                                                                    jiggleDocument: AnimationControllerJiggleDocument,
                                                                    jiggles: [Jiggle],
                                                                    jiggleCount: Int,
                                                                    animationMode: AnimatonMode,
                                                                    isContinuousDisableGrabEnabled: Bool) -> Bool {
        if isContinuousDisableGrabEnabled {
            switch animationMode {
            case .unknown:
                return false
            case .grab:
                return false
            case .continuous:
                flushAll(jiggleViewModel: jiggleViewModel,
                         jiggleDocument: jiggleDocument,
                         jiggles: jiggles,
                         jiggleCount: jiggleCount,
                         animationMode: animationMode)
                return true
            case .loops:
                return false
            }
        }
        return false
    }
    
    @MainActor private func checkSliderActiveAndFlushIfNeeded(jiggleViewModel: AnimationControllerJiggleViewModel,
                                                              jiggleDocument: AnimationControllerJiggleDocument,
                                                              jiggles: [Jiggle],
                                                              jiggleCount: Int,
                                                              animationMode: AnimatonMode,
                                                              isAnySliderActive: Bool) -> Bool {
        if isAnySliderActive {
            flushAll(jiggleViewModel: jiggleViewModel,
                     jiggleDocument: jiggleDocument,
                     jiggles: jiggles,
                     jiggleCount: jiggleCount,
                     animationMode: animationMode)
            return true
        }
        return false
    }
    
}
