//
//  TimeLineControlPoint.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 9/12/24.
//

import Foundation

public class TimeLineControlPoint {
    
    func read(_ timeLineControlPoint: TimeLineControlPoint) {
        normalizedTanDirection = timeLineControlPoint.normalizedTanDirection
        normalizedTanMagnitudeIn = timeLineControlPoint.normalizedTanMagnitudeIn
        normalizedTanMagnitudeOut = timeLineControlPoint.normalizedTanMagnitudeOut
        isManualPositionEnabled = timeLineControlPoint.isManualPositionEnabled
        isManualTanHandleEnabled = timeLineControlPoint.isManualTanHandleEnabled
        normalizedX = timeLineControlPoint.normalizedX
        normalizedY = timeLineControlPoint.normalizedY
    }
    
    typealias Point = Math.Point
    
    public struct TanHandles {
        public let inX: Float
        public let inY: Float
        public let outX: Float
        public let outY: Float
    }
    
    public var normalizedTanDirection = Float(0.0)
    public var normalizedTanMagnitudeIn = Float(0.0)
    public var normalizedTanMagnitudeOut = Float(0.0)
    
    public var normalizedX = Float(0.0)
    public var normalizedY = Float(0.0)
    
    public var isManualPositionEnabled = false
    public var isManualTanHandleEnabled = false
    
    var tempX = Float(0.0)
    var tempY = Float(0.0)
    
    var defaultX = Float(0.0)
    var defaultY = Float(0.0)
    
    func disableManualTanHandle() {
        isManualTanHandleEnabled = false
    }
    
    func getPercent(index: Int,
                    count: Int) -> Float {
        if count > 1 {
            var result = Float(index) / Float(count - 1)
            if result < 0.0 { result = 0.0 }
            if result > 1.0 { result = 1.0 }
            return result
        } else {
            return 0.5
        }
    }
    
    public func getX(frameWidth: Float,
              paddingH: Float) -> Float {
        paddingH + (normalizedX * (frameWidth - paddingH - paddingH))
    }
    
    public func getY(frameHeight: Float,
              paddingV: Float) -> Float {
        paddingV + ((1.0 - normalizedY) * (frameHeight - paddingV - paddingV))
    }
    
    static func getSplineFactorX(count: Int,
                                 frameWidth: Float,
                                 frameHeight: Float,
                                 paddingH: Float,
                                 paddingV: Float) -> Float {
        let width = frameWidth - (paddingH + paddingH)
        let height = frameHeight - (paddingV + paddingV)
        if width > Math.epsilon && height > Math.epsilon {
            return height / width
        } else {
            return 1.0
        }
    }
    
    public func getTanHandles(count: Int,
                       frameWidth: Float,
                       frameHeight: Float,
                       paddingH: Float,
                       paddingV: Float) -> TanHandles {
        let x = getX(frameWidth: frameWidth,
                     paddingH: paddingH)
        
        let y = getY(frameHeight: frameHeight,
                     paddingV: paddingV)
        let dirX = sinf(normalizedTanDirection)
        let dirY = -cosf(normalizedTanDirection)
        
        let width = (frameWidth - paddingH - paddingH)
        let height = (frameHeight - paddingV - paddingV)
        
        return TanHandles(inX: x - dirX * normalizedTanMagnitudeIn * width,
                          inY: y - dirY * normalizedTanMagnitudeIn * height,
                          outX: x + dirX * normalizedTanMagnitudeOut * width,
                          outY: y + dirY * normalizedTanMagnitudeOut * height)
    }
    
    func constraintRotationZP() {
        
        if normalizedTanDirection > Math.pi2 || normalizedTanDirection < Math._pi2 {
            normalizedTanDirection = fmodf(normalizedTanDirection, Math.pi2)
        }
        while normalizedTanDirection >= Math.pi2 {
            normalizedTanDirection -= Math.pi2
        }
        while normalizedTanDirection < 0.0 {
            normalizedTanDirection += Math.pi2
        }
    }
}


