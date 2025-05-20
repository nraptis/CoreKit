//
//  AnimationController+Flush.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/11/24.
//

import UIKit

extension AnimationController {
    
    @MainActor func flushAll(jiggleViewModel: AnimationControllerJiggleViewModel,
                             jiggleDocument: AnimationControllerJiggleDocument,
                             jiggles: [Jiggle],
                             jiggleCount: Int,
                             animationMode: AnimatonMode) {
        snapshot_pre(jiggles: jiggles,
                     jiggleCount: jiggleCount,
                     animationMode: animationMode)
        _flushPurgatoryAnimationTouches_All()
        _flushAnimationTouches_All()
        snapshot_post(jiggleViewModel: jiggleViewModel,
                      jiggleDocument: jiggleDocument,
                      jiggles: jiggles,
                      jiggleCount: jiggleCount,
                      animationMode: animationMode)
        clock = 0.0
    }
    
    @MainActor func flushAllExpired(jiggleViewModel: AnimationControllerJiggleViewModel,
                                    jiggleDocument: AnimationControllerJiggleDocument,
                                    jiggles: [Jiggle],
                                    jiggleCount: Int,
                                    animationMode: AnimatonMode) {
        
        var isAnyTouchExpired = false
        for animationTouchIndex in 0..<animationTouchCount {
            let animationTouch = animationTouches[animationTouchIndex]
            if animationTouch.isExpired {
                isAnyTouchExpired = true
            }
        }
        for animationTouchIndex in 0..<purgatoryAnimationTouchCount {
            let animationTouch = purgatoryAnimationTouches[animationTouchIndex]
            if animationTouch.isExpired {
                isAnyTouchExpired = true
            }
        }
        
        if isAnyTouchExpired {
            snapshot_pre(jiggles: jiggles,
                         jiggleCount: jiggleCount,
                         animationMode: animationMode)
            _flushAnimationTouches_Expired()
            _flushPurgatoryAnimationTouches_Expired()
            snapshot_post(jiggleViewModel: jiggleViewModel,
                          jiggleDocument: jiggleDocument,
                          jiggles: jiggles,
                          jiggleCount: jiggleCount,
                          animationMode: animationMode)
        }
    }
    
    @MainActor func _flushAnimationTouches_All() {
        tempAnimationTouchCount = 0
        for animationTouchIndex in 0..<animationTouchCount {
            let animationTouch = animationTouches[animationTouchIndex]
            tempAnimationTouchesAddUnique(animationTouch)
        }
        for animationTouchIndex in 0..<tempAnimationTouchCount {
            let animationTouch = tempAnimationTouches[animationTouchIndex]
            animationTouchesRemove(animationTouch: animationTouch)
        }
    }
    
    func _flushPurgatoryAnimationTouches_All() {
        tempAnimationTouchCount = 0
        for animationTouchIndex in 0..<purgatoryAnimationTouchCount {
            let animationTouch = purgatoryAnimationTouches[animationTouchIndex]
            tempAnimationTouchesAddUnique(animationTouch)
        }
        for animationTouchIndex in 0..<tempAnimationTouchCount {
            let animationTouch = tempAnimationTouches[animationTouchIndex]
            purgatoryAnimationTouchesRemove(animationTouch)
        }
    }
    
    @MainActor func _flushAnimationTouches_Expired() {
        tempAnimationTouchCount = 0
        for animationTouchIndex in 0..<animationTouchCount {
            let animationTouch = animationTouches[animationTouchIndex]
            if animationTouch.isExpired {
                tempAnimationTouchesAddUnique(animationTouch)
            }
        }
        
        for animationTouchIndex in 0..<tempAnimationTouchCount {
            let animationTouch = tempAnimationTouches[animationTouchIndex]
            animationTouchesRemove(animationTouch: animationTouch)
        }
    }
    
    func _flushPurgatoryAnimationTouches_Expired() {
        tempAnimationTouchCount = 0
        for animationTouchIndex in 0..<purgatoryAnimationTouchCount {
            let animationTouch = purgatoryAnimationTouches[animationTouchIndex]
            if animationTouch.isExpired {
                tempAnimationTouchesAddUnique(animationTouch)
            }
        }
        
        for animationTouchIndex in 0..<tempAnimationTouchCount {
            let animationTouch = tempAnimationTouches[animationTouchIndex]
            purgatoryAnimationTouchesRemove(animationTouch)
        }
    }
    
    @MainActor func _flushAnimationTouches_TouchMatch(touches: [UITouch]) {
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
    }
    
    @MainActor func _flushPurgatoryAnimationTouches_TouchMatch(touches: [UITouch]) {
        tempAnimationTouchCount = 0
        for touchIndex in 0..<touches.count {
            let touch = touches[touchIndex]
            if let animationTouch = purgatoryAnimationTouchesFind(touch: touch) {
                tempAnimationTouchesAddUnique(animationTouch)
            }
        }
        for animationTouchIndex in 0..<tempAnimationTouchCount {
            let animationTouch = tempAnimationTouches[animationTouchIndex]
            purgatoryAnimationTouchesRemove(animationTouch)
        }
    }
    
    @MainActor func _flushAnimationTouches_ModeMismatch(animationMode: AnimatonMode) {
        tempAnimationTouchCount = 0
        for animationTouchIndex in 0..<animationTouchCount {
            let animationTouch = animationTouches[animationTouchIndex]
            if !animationTouch.residency.matchesMode(animationMode: animationMode,
                                                     includingUnassigned: true) {
                tempAnimationTouchesAddUnique(animationTouch)
            }
        }
        
        for animationTouchIndex in 0..<tempAnimationTouchCount {
            let animationTouch = tempAnimationTouches[animationTouchIndex]
            animationTouchesRemove(animationTouch: animationTouch)
        }
    }
    
    @MainActor func _flushAnimationTouches_Orphaned(jiggles: [AnyObject],
                                                    jiggleCount: Int,) {
        tempAnimationTouchCount = 0
        for animationTouchIndex in 0..<animationTouchCount {
            let animationTouch = animationTouches[animationTouchIndex]
            switch animationTouch.residency {
            case .unassigned:
                break
            case .jiggleContinuous(let jiggle):
                var exists: Bool = false
                for jiggleIndex in 0..<jiggleCount {
                    if jiggles[jiggleIndex] === jiggle {
                        exists = true
                        break
                    }
                }
                if exists {
                    tempAnimationTouchesAddUnique(animationTouch)
                }
            case .jiggleGrab(let jiggle):
                var exists: Bool = false
                for jiggleIndex in 0..<jiggleCount {
                    if jiggles[jiggleIndex] === jiggle {
                        exists = true
                        break
                    }
                }
                if exists {
                    tempAnimationTouchesAddUnique(animationTouch)
                }
            }
        }
        
        for animationTouchIndex in 0..<tempAnimationTouchCount {
            let animationTouch = tempAnimationTouches[animationTouchIndex]
            animationTouchesRemove(animationTouch: animationTouch)
        }
    }
}
