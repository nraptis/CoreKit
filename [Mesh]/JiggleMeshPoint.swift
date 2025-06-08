//
//  JiggleMeshPoint.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 2/17/24.
//

import Foundation

public class JiggleMeshPoint {
    
    public var isEdge = false
    
    public var baseX = Float(0.0)
    public var baseY = Float(0.0)
    public var baseZ = Float(0.0)
    
    public var transformedX = Float(0.0)
    public var transformedY = Float(0.0)
    public var transformedZ = Float(0.0)
    
    public var animatedX = Float(0.0)
    public var animatedY = Float(0.0)
    public var animatedZ = Float(0.0)
    
    public var normalX = Float(0.0)
    public var normalY = Float(0.0)
    public var normalZ = Float(0.0)
    
    public var u = Float(0.0)
    public var v = Float(0.0)
    
    public var height = Float(0.0)
    
    public var percent = Float(0.0)
    
    // These are used on a level pass, subject to change.
    var distanceWeightCenter = Float(0.0)
    
    //var distancePercent = Float(0.0)
    
    //public var percentInner = Float(0.0)
    public var bleed = Float(1.0)
    
    public var distanceInner = Float(0.0)
    public var distanceOuter = Float(0.0)
    
    //public var distanceFromEdge = Float(0.0)
    
    public var depth = 0
    
    @inline(__always) func calculateOuterDistance(guideWeightSegments: [GuideWeightSegment],
                                              guideWeightSegmentCount: Int) {
        var _bestDistanceSquared = Float(100_000_000.0)
        for guideWeightSegmentIndex in 0..<guideWeightSegmentCount {
            let guideWeightSegment = guideWeightSegments[guideWeightSegmentIndex]
            let distanceSquared = guideWeightSegment.distanceSquaredToClosestPoint(baseX, baseY)
            if distanceSquared < _bestDistanceSquared {
                _bestDistanceSquared = distanceSquared
            }
        }
        
        if _bestDistanceSquared > Math.epsilon {
            distanceOuter = sqrtf(_bestDistanceSquared)
        } else {
            distanceOuter = Float(0.0)
        }
    }
    
    @inline(__always) func calculateInnerDistance(guideWeightSegments: [GuideWeightSegment],
                                              guideWeightSegmentCount: Int) {
        var _bestDistanceSquared = Float(100_000_000.0)
        for guideWeightSegmentIndex in 0..<guideWeightSegmentCount {
            let guideWeightSegment = guideWeightSegments[guideWeightSegmentIndex]
            let distanceSquared = guideWeightSegment.distanceSquaredToClosestPoint(baseX, baseY)
            if distanceSquared < _bestDistanceSquared {
                _bestDistanceSquared = distanceSquared
            }
        }
        
        if _bestDistanceSquared > Math.epsilon {
            distanceInner = sqrtf(_bestDistanceSquared)
        } else {
            distanceInner = Float(0.0)
        }
    }
    
    
    
    public func updateActive(amountX: Float,
                      amountY: Float,
                      guideCenterX: Float,
                      guideCenterY: Float,
                      jiggleCenterX: Float,
                      jiggleCenterY: Float,
                      rotationFactor: Float,
                      scaleFactor: Float) {

        let shiftX = percent * amountX
        let shiftY = percent * amountY
        
        if rotationFactor != 0.0 || scaleFactor != 0.0 {
            
            let rotation = rotationFactor * Math.pi_4 * percent
            
            var scale: Float
            if scaleFactor < 0.0 {
                let minScale = Float(0.64)
                scale = 1.0 - (1.0 - minScale) * (-scaleFactor) * percent
            } else if scaleFactor > 0.0 {
                let maxScale = Float(1.6)
                scale = 1.0 + (maxScale - 1.0) * scaleFactor * percent
            } else {
                scale = 1.0
            }
            
            let diffX = transformedX - jiggleCenterX
            let diffY = transformedY - jiggleCenterY
            
            let distanceSquared = diffX * diffX + diffY * diffY
            if distanceSquared > Math.epsilon {
                
                let distance = sqrtf(distanceSquared)
                
                let pivotRotation = rotation - atan2f(-diffX, -diffY)
                let spokeX = sinf(Float(pivotRotation)) * distance * scale
                let spokeY = -cosf(Float(pivotRotation)) * distance * scale
                
                animatedX = spokeX + jiggleCenterX + shiftX
                animatedY = spokeY + jiggleCenterY + shiftY
                
            } else {
                // This part scales exactly correctly...
                animatedX = transformedX + shiftX
                animatedY = transformedY + shiftY
            }
            
        } else {
            // This part scales exactly correctly...
            animatedX = transformedX + shiftX
            animatedY = transformedY + shiftY
        }
    }
    
    public func updateInactive() {
        animatedX = transformedX
        animatedY = transformedY
    }
    
    public var pointTransformed: Math.Point {
        Math.Point(x: transformedX,
              y: transformedY)
    }
    
    public var pointAnimated: Math.Point {
        Math.Point(x: animatedX,
              y: animatedY)
    }
    
}
