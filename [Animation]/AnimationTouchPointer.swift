//
//  AnimationTouchPointer.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/8/24.
//

import Foundation

class AnimationTouchPointer {
    
    static let expireTime = (AnimationTouch.expireTime + AnimationTouch.expireTime * 0.5)
    
    var touchID: ObjectIdentifier
    var x = Float(0.0)
    var y = Float(0.0)
    
    var stationaryTime = Float(0.0)
    var isExpired = false
    
    var actionType = AnimationTouchPointerActionType.detached
    
    var isConsidered = false
    
    var isCaptureStartScaleValid = false
    var captureStartDistance = Float(0.0)
    var captureTrackDistance = Float(0.0)
    
    var isCaptureStartRotateValid = false
    var captureStartAngle = Float(0.0)
    var captureTrackAngle = Float(0.0)
    var captureTrackAngleDifference = Float(0.0)
    
    init(touchID: ObjectIdentifier) {
        self.touchID = touchID
    }
    
    func update(deltaTime: Float) {
        stationaryTime += deltaTime
        if stationaryTime >= Self.expireTime {
            isExpired = true
        }
    }
}
