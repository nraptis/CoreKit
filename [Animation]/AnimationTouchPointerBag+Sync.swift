//
//  AnimationTouchPointerBag+Sync.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/19/24.
//

import Foundation

extension AnimationTouchPointerBag {
    
    func sync(jiggle: AnyObject,
              animationTouches: [AnimationTouch],
              animationTouchCount: Int,
              command: AnimationTouchStateCommand,
              stateBag: AnimationTouchStateBag) {
        sync_DetachAllTouchPointers()
        sync_GatherFromAnimationTouches(jiggle: jiggle,
                                        animationTouches: animationTouches,
                                        animationTouchCount: animationTouchCount)
        sync_GatherFromCommand(command: command)
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    func sync_DetachAllTouchPointers() {
        for pointerIndex in 0..<touchPointerCount {
            let pointer = touchPointers[pointerIndex]
            pointer.actionType = .detached
        }
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    func sync_GatherFromAnimationTouches(jiggle: AnyObject,
                                         animationTouches: [AnimationTouch],
                                         animationTouchCount: Int) {
        for animationTouchIndex in 0..<animationTouchCount {
            let animationTouch = animationTouches[animationTouchIndex]
            let touchID = animationTouch.touchID
            
            switch animationTouch.residency {
            case .unassigned:
                break
            case .jiggleContinuous(let residencyJiggle):
                if residencyJiggle === jiggle {
                    switch format {
                    case .grab:
                        break
                    case .continuous:
                        if let touchPointer = touchPointersFind(touchID: touchID) {
                            touchPointer.actionType = .retained(animationTouch.x, animationTouch.y)
                            touchPointer.stationaryTime = 0.0
                            touchPointer.isExpired = false
                        }
                    }
                }
            case .jiggleGrab(let residencyJiggle):
                if residencyJiggle === jiggle {
                    switch format {
                    case .grab:
                        if let touchPointer = touchPointersFind(touchID: touchID) {
                            touchPointer.actionType = .retained(animationTouch.x, animationTouch.y)
                            touchPointer.stationaryTime = 0.0
                            touchPointer.isExpired = false
                        }
                    case .continuous:
                        break
                    }
                }
            }
        }
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    func sync_GatherFromCommand(command: AnimationTouchStateCommand) {
        
        // For each command...
        for chunkIndex in 0..<command.chunkCount {
            let chunk = command.chunks[chunkIndex]
            
            // There's 3 types of chunk:
            // 1.) add(ObjectIdentifier, Float, Float)
            // 2.) remove(ObjectIdentifier)
            // 3.) move(ObjectIdentifier, Float, Float)
            switch chunk {
            case .add(let commandChunktouchID, let x, let y):
                if let touchPointer = touchPointersFind(touchID: commandChunktouchID) {
                    touchPointer.actionType = .add(x, y)
                    touchPointer.x = x
                    touchPointer.y = y
                    touchPointer.stationaryTime = 0.0
                    touchPointer.isExpired = false
                    
                } else {
                    let newTouchPointer = AnimationPartsFactory.shared.withdrawAnimationTouchPointer(touchID: commandChunktouchID)
                    newTouchPointer.actionType = .add(x, y)
                    newTouchPointer.x = x
                    newTouchPointer.y = y
                    touchPointersAddUnique(newTouchPointer)
                }
            case .remove(let commandChunktouchID):
                
                if let touchPointer = touchPointersFind(touchID: commandChunktouchID) {
                    touchPointer.actionType = .remove
                    touchPointer.stationaryTime = 0.0
                    touchPointer.isExpired = false
                } else {
                    let newTouchPointer = AnimationPartsFactory.shared.withdrawAnimationTouchPointer(touchID: commandChunktouchID)
                    newTouchPointer.actionType = .remove
                    touchPointersAddUnique(newTouchPointer)
                }
            case .move(let commandChunktouchID, let x, let y):
                if let touchPointer = touchPointersFind(touchID: commandChunktouchID) {
                    touchPointer.actionType = .move(x, y)
                    touchPointer.x = x
                    touchPointer.y = y
                    touchPointer.stationaryTime = 0.0
                    touchPointer.isExpired = false
                    
                } else {
                    let newTouchPointer = AnimationPartsFactory.shared.withdrawAnimationTouchPointer(touchID: commandChunktouchID)
                    newTouchPointer.actionType = .move(x, y)
                    newTouchPointer.x = x
                    newTouchPointer.y = y
                    touchPointersAddUnique(newTouchPointer)
                }
            }
        }
    }
}
