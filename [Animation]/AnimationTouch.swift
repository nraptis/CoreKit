//
//  AnimationTouch.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/7/24.
//

import UIKit

class AnimationTouch {
    
    static let expireTime = Float(8.0)
    
    typealias Point = Math.Point
    
    var x = Float(0.0)
    var y = Float(0.0)
    var touchID: ObjectIdentifier
    var residency = AnimationTouchResidency.unassigned
    var stationaryTime = Float(0.0)
    var isExpired = false
    var history = AnimationTouchHistory()
    
    init(touchID: ObjectIdentifier) {
        self.touchID = touchID
    }
    
    var point: Point {
        Point(x: x, y: y)
    }
    
    func update(deltaTime: Float, clock: Float) {
        if isExpired == false {
            stationaryTime += deltaTime
            history.update(deltaTime: deltaTime, clock: clock)
            if stationaryTime >= Self.expireTime {
                isExpired = true
            }
        }
    }
    
    func linkToResidency(residency: AnimationTouchResidency) {
        self.residency = residency
        stationaryTime = 0.0
        isExpired = false
    }
    
    func recordHistory(clock: Float) {
        history.recordHistory(clock: clock, x: x, y: y)
    }
    
    func release() -> ReleaseData {
        history.release()
    }
    
}
