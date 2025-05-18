//
//  AnimationTouchPointerActionType.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/8/24.
//

import Foundation

enum AnimationTouchPointerActionType {
    case detached
    case retained(Float, Float)
    case add(Float, Float)
    case remove
    case move(Float, Float)
    
    var isDetachedOrRetained: Bool {
        switch self {
        case .detached:
            return true
        case .retained:
            return true
        default:
            return false
        }
    }
}
