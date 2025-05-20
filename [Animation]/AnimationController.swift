//
//  AnimationController.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/7/24.
//

import UIKit
import Combine

public protocol AnimationControllerJiggleDocument: AnyObject {
    @MainActor var animationContinuousDraggingPublisher: PassthroughSubject<Void, Never> { get }
    @MainActor var animationContinuousScalePublisher: PassthroughSubject<Void, Never> { get }
    @MainActor var animationContinuousRotationPublisher: PassthroughSubject<Void, Never> { get }
    @MainActor var animationContinuousSyncAllPublisher: PassthroughSubject<Void, Never> { get }
    @MainActor func switchSelectedJiggle(newSelectedJiggleIndex: Int,
                                         displayMode: DisplayMode,
                                         isPrecise: Bool)
    
    func getJiggleAnyObject(_ index: Int) -> AnyObject?
    
    func getJiggleToSelect(points: [Math.Point],
                           command: SelectJiggleCommand,
                           touchTargetTouchSource: TouchTargetTouchSource) -> SelectJiggleResponse
    
    @MainActor func attemptSelectJiggle(points: [Math.Point],
                                        command: SelectJiggleCommand,
                                        nullifySelectionIfWhiff: Bool,
                                        displayMode: DisplayMode,
                                        touchTargetTouchSource: TouchTargetTouchSource,
                                        isPrecise: Bool) -> Bool
    
}

public protocol AnimationControllerJiggleViewModel: AnyObject {
    @MainActor func continuousRealizeJiggleDidStartGrab()
    @MainActor func continuousRealizeJiggleDidStopGrab(jiggle: Jiggle)
}

public protocol AnimationControllerJiggle: AnyObject {
    var animationWad: AnimationWad { get }
}

public class AnimationController {
    
    public init() {
        
    }
    
    typealias Point = Math.Point
    typealias Vector = Math.Vector
    
    // This list retains the touches.
    var animationTouches = [AnimationTouch]()
    var animationTouchCount = 0
    
    // This list retains the touches.
    var purgatoryAnimationTouches = [AnimationTouch]()
    var purgatoryAnimationTouchCount = 0
    
    // This list does not retain the touches.
    var tempAnimationTouchCount = 0
    var tempAnimationTouches = [AnimationTouch]()
    
    // This list does not retain the touches.
    var releaseAnimationTouches = [AnimationTouch]()
    var releaseAnimationTouchCount = 0
    
    var clock = Float(0.0)
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    @MainActor public func update(deltaTime: Float,
                                  jiggleViewModel: AnimationControllerJiggleViewModel,
                                  jiggleDocument: AnimationControllerJiggleDocument,
                                  jiggles: [Jiggle],
                                  jiggleCount: Int,
                                  isGyroEnabled: Bool,
                                  animationMode: AnimatonMode,
                                  gyroSmoothX: Float,
                                  gyroSmoothY: Float) {
        
        clock += deltaTime
        
        for animationTouchIndex in 0..<purgatoryAnimationTouchCount {
            let animationTouch = purgatoryAnimationTouches[animationTouchIndex]
            animationTouch.update(deltaTime: deltaTime, clock: clock)
        }
        
        for animationTouchIndex in 0..<animationTouchCount {
            let animationTouch = animationTouches[animationTouchIndex]
            animationTouch.update(deltaTime: deltaTime, clock: clock)
        }
        
        flushAllExpired(jiggleViewModel: jiggleViewModel,
                        jiggleDocument: jiggleDocument,
                        jiggles: jiggles,
                        jiggleCount: jiggleCount,
                        animationMode: animationMode)
        
        
        // [Animation Mode Verify] 12-18-2024
        // This seems a little bit like rabbit hole
        // logic. The alternative is to do this
        // same loop on JiggleDocument immediately
        // after this update. I like this choice better.
        for jiggleIndex in 0..<jiggleCount {
            let jiggle = jiggles[jiggleIndex]
            let animationWad = jiggle.animationWad
            
            switch animationMode {
            case .unknown:
                animationWad.animationInstructionGrab.update_Inactive(deltaTime: deltaTime)
                animationWad.animationInstructionContinuous.update_Inactive(deltaTime: deltaTime)
                animationWad.animationInstructionLoops.update_Inactive(deltaTime: deltaTime)
            case .grab:
                animationWad.animationInstructionGrab.update_Active(deltaTime: deltaTime,
                                                                    animationWad: animationWad,
                                                                    isGyroEnabled: isGyroEnabled,
                                                                    clock: clock,
                                                                    gyroSmoothX: gyroSmoothX,
                                                                    gyroSmoothY: gyroSmoothY)
                animationWad.animationInstructionContinuous.update_Inactive(deltaTime: deltaTime)
                animationWad.animationInstructionLoops.update_Inactive(deltaTime: deltaTime)
            case .continuous:
                animationWad.animationInstructionGrab.update_Inactive(deltaTime: deltaTime)
                animationWad.animationInstructionContinuous.update_Active(deltaTime: deltaTime,
                                                                          animationWad: animationWad,
                                                                          jiggleDocument: jiggleDocument,
                                                                          isGyroEnabled: isGyroEnabled,
                                                                          clock: clock)
            case .loops:
                animationWad.animationInstructionGrab.update_Inactive(deltaTime: deltaTime)
                animationWad.animationInstructionContinuous.update_Inactive(deltaTime: deltaTime)
                animationWad.animationInstructionLoops.update_Active(deltaTime: deltaTime,
                                                                     animationWad: animationWad,
                                                                     jiggleDocument: jiggleDocument,
                                                                     isGyroEnabled: isGyroEnabled)
            }
        }
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    // The function seems a little lonely, it's not
    // really grouped with any similar function.
    // I don't think it needs its own extension.
    func notifyJiggleUngrabbed_Grab(animationMode: AnimatonMode,
                                    jiggle: AnyObject,
                                    measuredSize: Float,
                                    grabSpeed: Float,
                                    animationInstructionGrab: AnimationInstructionGrab) {
        
        // We copy all the "purgatory touches"
        // which are "grab" and "same jiggle"
        // into our "release touches," these
        // will be used to compute the "fling...!!!"
        releaseAnimationTouchCount = 0
        for animationTouchIndex in 0..<purgatoryAnimationTouchCount {
            let animationTouch = purgatoryAnimationTouches[animationTouchIndex]
            switch animationTouch.residency {
            case .unassigned:
                break
            case .jiggleContinuous:
                break
            case .jiggleGrab(let residencyJiggle):
                if residencyJiggle === jiggle {
                    releaseAnimationTouchesAddUnique(animationTouch)
                }
            }
        }
        
        // Execute the fling.
        animationInstructionGrab.fling(measuredSize: measuredSize,
                                       grabSpeed: grabSpeed,
                                       releaseAnimationTouches: releaseAnimationTouches,
                                       releaseAnimationTouchCount: releaseAnimationTouchCount)
        
        // Then we can remove them from purgatory.
        // We have no further use for these touches.
        // We only kept them around for this very purpose.
        //
        for animationTouchIndex in 0..<releaseAnimationTouchCount {
            let animationTouch = releaseAnimationTouches[animationTouchIndex]
            purgatoryAnimationTouchesRemove(animationTouch)
        }
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    //
    // We've explored both alternatives.
    // 1.) Only Recording history for a linked touch.
    // 2.) Recording history for all the touches.
    //
    func recordHistoryForTouches(touches: [UITouch]) {
        for touchIndex in 0..<touches.count {
            let touch = touches[touchIndex]
            if let animationTouch = animationTouchesFind(touch: touch) {
                animationTouch.recordHistory(clock: clock)
            }
        }
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    // A good candidate for a better name...
    @MainActor func snapshot_pre(jiggles: [Jiggle],
                                 jiggleCount: Int,
                                 animationMode: AnimatonMode) {
        for jiggleIndex in 0..<jiggleCount {
            let jiggle = jiggles[jiggleIndex]
            let animationWad = jiggle.animationWad
            switch animationMode {
            case .unknown:
                break
            case .grab:
                animationWad.animationInstructionGrab.stateBag.snapshotBefore(jiggle: jiggle,
                                                                              animationTouches: animationTouches,
                                                                              animationTouchCount: animationTouchCount)
                jiggle.animationWad.captureTouchCountGrabBefore = animationTouchesCount(jiggle: jiggle, format: .grab)
            case .continuous:
                animationWad.animationInstructionContinuous.stateBag.snapshotBefore(jiggle: jiggle,
                                                                                    animationTouches: animationTouches,
                                                                                    animationTouchCount: animationTouchCount)
                jiggle.animationWad.captureTouchCountContinuousBefore = animationTouchesCount(jiggle: jiggle, format: .continuous)
            case .loops:
                break
            }
        }
    }
    
    @MainActor func snapshot_post(jiggleViewModel: AnimationControllerJiggleViewModel,
                                  jiggleDocument: AnimationControllerJiggleDocument,
                                  jiggles: [Jiggle],
                                  jiggleCount: Int,
                                  animationMode: AnimatonMode) {
        for jiggleIndex in 0..<jiggleCount {
            let jiggle = jiggles[jiggleIndex]
            switch animationMode {
            case .unknown:
                break
            case .grab:
                let animationWad = jiggle.animationWad
                animationWad.animationInstructionGrab.stateBag.snapshotAfter(jiggle: jiggle,
                                                                             animationTouches: animationTouches,
                                                                             animationTouchCount: animationTouchCount)
                animationWad.animationInstructionGrab.stateBag.generateAppropriateCommands()
                animationWad.animationInstructionGrab.performStateCommands(jiggle: jiggle,
                                                                           jiggleDocument: jiggleDocument,
                                                                           animationTouches: animationTouches,
                                                                           animationTouchCount: animationTouchCount)
                jiggle.animationWad.captureTouchCountGrabAfter = animationTouchesCount(jiggle: jiggle, format: .grab)
                if (jiggle.animationWad.captureTouchCountGrabBefore <= 0) && (jiggle.animationWad.captureTouchCountGrabAfter >= 1) {
                    jiggle.animationWad.isCaptureActiveGrab = true
                }
                if (jiggle.animationWad.captureTouchCountGrabBefore >= 1) && (jiggle.animationWad.captureTouchCountGrabAfter <= 0) {
                    jiggle.animationWad.isCaptureActiveGrab = false
                    notifyJiggleUngrabbed_Grab(animationMode: animationMode,
                                               jiggle: jiggle,
                                               measuredSize: animationWad.measuredSize,
                                               grabSpeed: animationWad.grabSpeed,
                                               animationInstructionGrab: animationWad.animationInstructionGrab)
                }
            case .continuous:
                let animationWad = jiggle.animationWad
                animationWad.animationInstructionContinuous.stateBag.snapshotAfter(jiggle: jiggle,
                                                                                   animationTouches: animationTouches,
                                                                                   animationTouchCount: animationTouchCount)
                animationWad.animationInstructionContinuous.stateBag.generateAppropriateCommands()
                animationWad.animationInstructionContinuous.performStateCommands(jiggle: jiggle,
                                                                                 jiggleDocument: jiggleDocument,
                                                                                 animationTouches: animationTouches,
                                                                                 animationTouchCount: animationTouchCount)
                jiggle.animationWad.captureTouchCountContinuousAfter = animationTouchesCount(jiggle: jiggle, format: .continuous)
                if (jiggle.animationWad.captureTouchCountContinuousBefore <= 0) && (jiggle.animationWad.captureTouchCountContinuousAfter >= 1) {
                    jiggle.animationWad.snapShotContinuousDragHistory()
                    jiggle.animationWad.isCaptureActiveContinuous = true
                    jiggleViewModel.continuousRealizeJiggleDidStartGrab()
                }
                if (jiggle.animationWad.captureTouchCountContinuousBefore >= 1) && (jiggle.animationWad.captureTouchCountContinuousAfter <= 0) {
                    jiggle.animationWad.isCaptureActiveContinuous = false
                    animationWad.animationInstructionContinuous.captureContinuousStartConditions(animationWad: animationWad,
                                                                                                 jiggleDocument: jiggleDocument)
                    animationWad.animationInstructionContinuous.snapToAnimationStartFrame(animationWad: animationWad)
                    jiggleViewModel.continuousRealizeJiggleDidStopGrab(jiggle: jiggle)
                }
            case .loops:
                break
            }
        }
    }
    
    @MainActor public func handleJigglesDidChange(jiggleViewModel: AnimationControllerJiggleViewModel,
                                                  jiggleDocument: AnimationControllerJiggleDocument,
                                                  jiggles: [Jiggle],
                                                  jiggleCount: Int,
                                                  animationMode: AnimatonMode) {
        
        snapshot_pre(jiggles: jiggles,
                     jiggleCount: jiggleCount,
                     animationMode: animationMode)
        _flushAnimationTouches_Orphaned(jiggles: jiggles,
                                        jiggleCount: jiggleCount)
        snapshot_post(jiggleViewModel: jiggleViewModel,
                      jiggleDocument: jiggleDocument,
                      jiggles: jiggles,
                      jiggleCount: jiggleCount,
                      animationMode: animationMode)
        
    }
    
    @MainActor public func handleAnimationModeDidChange(jiggleViewModel: AnimationControllerJiggleViewModel,
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
    
    @MainActor public func handleDocumentModeDidChange(jiggleViewModel: AnimationControllerJiggleViewModel,
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
    
    
    
    @MainActor public func applicationWillResignActive(jiggleViewModel: AnimationControllerJiggleViewModel,
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
    
}
