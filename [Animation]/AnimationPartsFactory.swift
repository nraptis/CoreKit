//
//  AnimationPartsFactory.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/7/24.
//

import UIKit

public class AnimationPartsFactory {
    
    public nonisolated(unsafe) static let shared = AnimationPartsFactory()
    
    @MainActor public func dispose() {
        animationTouches.removeAll(keepingCapacity: false)
        animationTouchCount = 0
        
        animationTouchStates.removeAll(keepingCapacity: false)
        animationTouchStateCount = 0
        
        animationTouchStateCommands.removeAll(keepingCapacity: false)
        animationTouchStateCommandCount = 0
        
        animationTouchPointers.removeAll(keepingCapacity: false)
        animationTouchPointerCount = 0
    }
    
    private var animationTouches = [AnimationTouch]()
    private var animationTouchCount = 0
    
    private var animationTouchStates = [AnimationTouchState]()
    private var animationTouchStateCount = 0
    
    private var animationTouchStateCommands = [AnimationTouchStateCommand]()
    private var animationTouchStateCommandCount = 0
    
    private var animationTouchPointers = [AnimationTouchPointer]()
    private var animationTouchPointerCount = 0
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    func withdrawAnimationTouch(touch: UITouch) -> AnimationTouch {
        let touchID = ObjectIdentifier(touch)
        if animationTouchCount > 0 {
            animationTouchCount -= 1
            let result = animationTouches[animationTouchCount]
            result.touchID = touchID
            return result
        }
        let result = AnimationTouch(touchID: touchID)
        return result
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    func depositAnimationTouch(_ animationTouch: AnimationTouch) {
        animationTouch.history.historyCount = 0
        animationTouch.stationaryTime = .zero
        animationTouch.residency = .unassigned
        animationTouch.isExpired = false
        while animationTouches.count <= animationTouchCount {
            animationTouches.append(animationTouch)
        }
        animationTouches[animationTouchCount] = animationTouch
        animationTouchCount += 1
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    func withdrawAnimationTouchState(touchID: ObjectIdentifier,
                                     x: Float,
                                     y: Float) -> AnimationTouchState {
        if animationTouchStateCount > 0 {
            animationTouchStateCount -= 1
            let result = animationTouchStates[animationTouchStateCount]
            result.touchID = touchID
            result.x = x
            result.y = y
            return result
        }
        let result = AnimationTouchState(x: x,
                                         y: y,
                                         touchID: touchID)
        return result
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    func depositAnimationTouchState(_ animationTouchState: AnimationTouchState) {
        while animationTouchStates.count <= animationTouchStateCount {
            animationTouchStates.append(animationTouchState)
        }
        animationTouchStates[animationTouchStateCount] = animationTouchState
        animationTouchStateCount += 1
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    func withdrawAnimationTouchStateCommand() -> AnimationTouchStateCommand {
        if animationTouchStateCommandCount > 0 {
            animationTouchStateCommandCount -= 1
            let result = animationTouchStateCommands[animationTouchStateCommandCount]
            return result
        }
        let result = AnimationTouchStateCommand()
        return result
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    func depositAnimationTouchStateCommand(_ animationTouchStateCommand: AnimationTouchStateCommand) {
        while animationTouchStateCommands.count <= animationTouchStateCommandCount {
            animationTouchStateCommands.append(animationTouchStateCommand)
        }
        animationTouchStateCommands[animationTouchStateCommandCount] = animationTouchStateCommand
        animationTouchStateCommandCount += 1
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    func withdrawAnimationTouchPointer(touchID: ObjectIdentifier) -> AnimationTouchPointer {
        if animationTouchPointerCount > 0 {
            animationTouchPointerCount -= 1
            let result = animationTouchPointers[animationTouchPointerCount]
            result.touchID = touchID
            return result
        }
        let result = AnimationTouchPointer(touchID: touchID)
        return result
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    func depositAnimationTouchPointer(_ animationTouchPointer: AnimationTouchPointer) {
        
        animationTouchPointer.isExpired = false
        animationTouchPointer.stationaryTime = .zero
        animationTouchPointer.actionType = .detached
        animationTouchPointer.isConsidered = false
        animationTouchPointer.isCaptureStartScaleValid = false
        animationTouchPointer.isCaptureStartRotateValid = false
        
        while animationTouchPointers.count <= animationTouchPointerCount {
            animationTouchPointers.append(animationTouchPointer)
        }
        animationTouchPointers[animationTouchPointerCount] = animationTouchPointer
        animationTouchPointerCount += 1
    }
    
}
