//
//  AnimationTouchStateBag.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/8/24.
//

import Foundation

class AnimationTouchStateBag {
    
    let format: AnimationTouchFormat
    init(format: AnimationTouchFormat) {
        self.format = format
    }
    
    var beforeStates = [AnimationTouchState]()
    var beforeStateCount = 0
    
    var afterStates = [AnimationTouchState]()
    var afterStateCount = 0
    
    var stateCommands = [AnimationTouchStateCommand]()
    var stateCommandCount = 0
    
    func snapshotBefore(jiggle: AnyObject,
                        animationTouches: [AnimationTouch],
                        animationTouchCount: Int) {
        
        // Purge the previously existing before states.
        for stateIndex in 0..<beforeStateCount {
            let state = beforeStates[stateIndex]
            AnimationPartsFactory.shared.depositAnimationTouchState(state)
        }
        beforeStateCount = 0
        
        // For each animation touch...
        for animationTouchIndex in 0..<animationTouchCount {
            
            // Get the touch...
            let animationTouch = animationTouches[animationTouchIndex]
            
            // For before state, including an expired touch.
            // If it expired, we will not add it to the after state...
            
            switch animationTouch.residency {
            case .unassigned:
                
                // If it's not related to *THIS* jiggle,
                // it's not in our sphere of influence.
                
                break
            case .jiggleContinuous(let residencyJiggle):
                
                // It's a touch that was registered in
                // continuous mode...
                
                if residencyJiggle === jiggle {
                    switch format {
                    case .grab:
                        break
                    case .continuous:
                        let touchID = animationTouch.touchID
                        let newState = AnimationPartsFactory.shared.withdrawAnimationTouchState(touchID: touchID,
                                                                                               x: animationTouch.x,
                                                                                               y: animationTouch.y)
                        beforeStatesAddUnique(newState)
                    }
                }
            case .jiggleGrab(let residencyJiggle):
                if residencyJiggle === jiggle {
                    
                    // ... With the same jiggle...
                    
                    switch format {
                    case .grab:
                        let touchID = animationTouch.touchID
                        let newState = AnimationPartsFactory.shared.withdrawAnimationTouchState(touchID: touchID,
                                                                                               x: animationTouch.x,
                                                                                               y: animationTouch.y)
                        beforeStatesAddUnique(newState)
                        
                    case .continuous:
                        break
                    }
                }
            }
        }
    }
    
    func snapshotAfter(jiggle: AnyObject,
                       animationTouches: [AnimationTouch],
                       animationTouchCount: Int) {
        
        // Purge the previously existing after states.
        for stateIndex in 0..<afterStateCount {
            let state = afterStates[stateIndex]
            AnimationPartsFactory.shared.depositAnimationTouchState(state)
        }
        afterStateCount = 0
        
        // For each animation touch...
        for animationTouchIndex in 0..<animationTouchCount {
            
            // Get the touch...
            let animationTouch = animationTouches[animationTouchIndex]
            
            // For after state, not including an expired touch.
            // This will effectively register as a "remove..." (due to expire)
            if animationTouch.isExpired {
                continue
            }
            
            switch animationTouch.residency {
            case .unassigned:
                
                // If it's not related to *THIS* jiggle,
                // it's not in our sphere of influence.
                
                break
            case .jiggleContinuous(let residencyJiggle):
                
                // It's a touch that was registered in
                // continuous mode...
                
                if residencyJiggle === jiggle {
                    
                    // ... With the same jiggle...
                    
                    switch format {
                    case .grab:
                        
                        // We are the state bag for grab, this touch
                        // is for continuous mode. it's not in our
                        // sphere of influence.
                        
                        break
                    case .continuous:
                        
                        // We are the state bag for continuous this touch
                        // is for continuous mode. It's one of our touches...
                        // So, we register the state (in this case, after)
                        
                        let touchID = animationTouch.touchID
                        let newState = AnimationPartsFactory.shared.withdrawAnimationTouchState(touchID: touchID,
                                                                                               x: animationTouch.x,
                                                                                               y: animationTouch.y)
                        afterStatesAddUnique(newState)
                        
                    }
                }
            case .jiggleGrab(let residencyJiggle):
                
                // It's a touch that was registered in
                // grab mode...
                
                if residencyJiggle === jiggle {
                    
                    // ... With the same jiggle...
                    
                    switch format {
                    case .grab:
                        
                        // We are the state bag for grab this touch
                        // is for grab mode. It's one of our touches...
                        // So, we register the state (in this case, after)
                        
                        let touchID = animationTouch.touchID
                        let newState = AnimationPartsFactory.shared.withdrawAnimationTouchState(touchID: touchID,
                                                                                               x: animationTouch.x,
                                                                                               y: animationTouch.y)
                        afterStatesAddUnique(newState)
                        
                    case .continuous:
                        
                        // We are the state bag for continuous, this touch
                        // is for grab mode. it's not in our
                        // sphere of influence.
                        
                        break
                    }
                }
            }
        }
    }
}
