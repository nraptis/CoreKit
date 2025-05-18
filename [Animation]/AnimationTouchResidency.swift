//
//  AnimationTouchResidency.swift
//  AnimationKit
//
//  Created by Nicholas Raptis on 5/10/25.
//

import Foundation

@frozen public enum AnimationTouchResidency {
    case unassigned
    case jiggleContinuous(AnyObject)
    case jiggleGrab(AnyObject)
    
    func matchesMode(animationMode: AnimatonMode,
                     includingUnassigned: Bool) -> Bool {
        
        switch animationMode {
        case .unknown:
            // No touches match with "unknown"...
            return false
        case .grab:
            switch self {
            case .unassigned:
                if includingUnassigned {
                    return true
                } else {
                    return false
                }
            case .jiggleContinuous:
                return false
            case .jiggleGrab:
                return true
            }
        case .continuous:
            switch self {
            case .unassigned:
                if includingUnassigned {
                    return true
                } else {
                    return false
                }
            case .jiggleContinuous:
                return true
            case .jiggleGrab:
                return false
            }
        case .loops:
            // No touches match with "unknown"...
            return false
        }
    }
    
}
