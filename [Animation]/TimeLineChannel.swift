//
//  TimeLineChannel.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 9/12/24.
//

import Foundation

public class TimeLineChannel {
    
    public enum DefaultType {
        case flat
        case curve
        case curveSmall
        case divot
        case divotSmall
        case swan
    }
    
    public var defaultType: DefaultType
    
    static let defaultMinimimYLarge = Float(0.25)
    static let defaultMaximumYLarge = Float(0.75)
    
    static let defaultMinimimYSmall = Float(0.25 + 0.125)
    static let defaultMaximumYSmall = Float(0.75 - 0.125)
    
    let smoother = TimeLineSmoother()
    public let controlPoints: [TimeLineControlPoint]
    let controlPointsTemp: [TimeLineControlPoint]
    public let controlPointCount: Int
    public let channelIndex: Int
    public let swatch: Swatch
    public let dummyControlPoint = TimeLineControlPoint()
    public init(controlPointCount: Int,
                channelIndex: Int,
                swatch: Swatch,
                defaultType: DefaultType) {
        var _controlPoints = [TimeLineControlPoint]()
        for _ in 0..<controlPointCount {
            let controlPoint = TimeLineControlPoint()
            _controlPoints.append(controlPoint)
        }
        var _controlPointsTemp = [TimeLineControlPoint]()
        for _ in 0..<controlPointCount {
            let controlPoint = TimeLineControlPoint()
            _controlPointsTemp.append(controlPoint)
        }
        self.controlPoints = _controlPoints
        self.controlPointsTemp = _controlPointsTemp
        self.controlPointCount = controlPointCount
        self.channelIndex = channelIndex
        self.swatch = swatch
        self.defaultType = defaultType
        
        for bucketIndex in 0..<TimeLineChannel.NUMBER_OF_BUCKETZ {
            let percent1 = Float(bucketIndex) / Float(TimeLineChannel.NUMBER_OF_BUCKETZ)
            let percent2 = Float(bucketIndex + 1) / Float(TimeLineChannel.NUMBER_OF_BUCKETZ)
            
            let startX = percent1 * TimeLineSmoother.SCALE - TimeLineChannel.BUCKETZ_EPZILON
            let endX = percent2 * TimeLineSmoother.SCALE + TimeLineChannel.BUCKETZ_EPZILON
            
            let bucket = TimeLineSegmentBucket(startX: startX, endX: endX)
            buckets.append(bucket)
        }
    }
    
    public func amplify(frameWidth: Float,
                        frameHeight: Float,
                        paddingH: Float,
                        paddingV: Float) {
        
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            let controlPointTemp = controlPointsTemp[controlPointIndex]
            controlPointTemp.read(controlPoint)
            controlPointTemp.tempY = controlPointTemp.normalizedY
        }
        
        var minY = Float(1.0)
        var maxY = Float(0.0)
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            minY = min(minY, controlPoint.normalizedY)
            maxY = max(maxY, controlPoint.normalizedY)
        }
        
        let rangeY = maxY - minY
        if rangeY > Math.epsilon {
            let centerY = minY + rangeY * 0.5
            
            for controlPointIndex in 0..<controlPointCount {
                let controlPointTemp = controlPointsTemp[controlPointIndex]
                
                controlPointTemp.normalizedY = centerY + (controlPointTemp.normalizedY - centerY) * 1.15
                if controlPointTemp.normalizedY > 1.0 {
                    controlPointTemp.normalizedY = 1.0
                }
                if controlPointTemp.normalizedY < 0.0 {
                    controlPointTemp.normalizedY = 0.0
                }
                controlPointTemp.isManualPositionEnabled = true
            }
        }
        
        let controlPointCount1 = (controlPointCount - 1)
        if controlPointCount1 > 0 {
            for controlPointIndex in 0..<controlPointCount1 {
                let controlPointTemp = controlPointsTemp[controlPointIndex]
                
                let swizzleRotation = Math.distanceBetweenAngles(controlPointTemp.normalizedTanDirection,
                                                                 Math.pi_2)
                if swizzleRotation > 0 {
                    controlPointTemp.constraintRotationZP()
                    controlPointTemp.normalizedTanDirection -= 0.05
                    if controlPointTemp.normalizedTanDirection < 0.0 { controlPointTemp.normalizedTanDirection = 0.0 }
                    controlPointTemp.isManualTanHandleEnabled = true
                }
                if swizzleRotation < 0 {
                    controlPointTemp.constraintRotationZP()
                    controlPointTemp.normalizedTanDirection += 0.05
                    if controlPointTemp.normalizedTanDirection > Math.pi { controlPointTemp.normalizedTanDirection = Math.pi }
                    controlPointTemp.isManualTanHandleEnabled = true
                }
                
            }
            controlPointsTemp[controlPointCount1].normalizedTanDirection = controlPointsTemp[0].normalizedTanDirection
        }
        
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            let controlPointTemp = controlPointsTemp[controlPointIndex]
            controlPoint.read(controlPointTemp)
        }
    }
    
    public func dampen(frameWidth: Float,
                       frameHeight: Float,
                       paddingH: Float,
                       paddingV: Float) {
        
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            let controlPointTemp = controlPointsTemp[controlPointIndex]
            controlPointTemp.read(controlPoint)
            controlPointTemp.tempY = controlPointTemp.normalizedY
        }
        
        var minY = Float(1.0)
        var maxY = Float(0.0)
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            minY = min(minY, controlPoint.normalizedY)
            maxY = max(maxY, controlPoint.normalizedY)
        }
        
        let rangeY = maxY - minY
        if rangeY > Math.epsilon {
            let centerY = minY + rangeY * 0.5
            
            for controlPointIndex in 0..<controlPointCount {
                let controlPointTemp = controlPointsTemp[controlPointIndex]
                controlPointTemp.normalizedY = centerY + (controlPointTemp.normalizedY - centerY) * 0.8
                if controlPointTemp.normalizedY > 1.0 {
                    controlPointTemp.normalizedY = 1.0
                }
                if controlPointTemp.normalizedY < 0.0 {
                    controlPointTemp.normalizedY = 0.0
                }
                controlPointTemp.isManualPositionEnabled = true
            }
        }
        
        let controlPointCount1 = (controlPointCount - 1)
        if controlPointCount1 > 0 {
            for controlPointIndex in 0..<controlPointCount1 {
                let controlPointTemp = controlPointsTemp[controlPointIndex]
                
                let swizzleRotation = Math.distanceBetweenAngles(controlPointTemp.normalizedTanDirection,
                                                                 Math.pi_2)
                if swizzleRotation > 0 {
                    controlPointTemp.constraintRotationZP()
                    controlPointTemp.normalizedTanDirection += 0.05
                    if controlPointTemp.normalizedTanDirection > Math.pi_2 {
                        controlPointTemp.normalizedTanDirection = Math.pi_2
                    }
                    controlPointTemp.isManualTanHandleEnabled = true
                }
                if swizzleRotation < 0 {
                    controlPointTemp.constraintRotationZP()
                    controlPointTemp.normalizedTanDirection -= 0.05
                    if controlPointTemp.normalizedTanDirection < Math.pi_2 {
                        controlPointTemp.normalizedTanDirection = Math.pi_2
                    }
                    controlPointTemp.isManualTanHandleEnabled = true
                }
                
            }
            controlPointsTemp[controlPointCount1].normalizedTanDirection = controlPointsTemp[0].normalizedTanDirection
        }
        
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            let controlPointTemp = controlPointsTemp[controlPointIndex]
            controlPoint.read(controlPointTemp)
        }
    }
    
    public func invertH(frameWidth: Float,
                        frameHeight: Float,
                        paddingH: Float,
                        paddingV: Float) {
        
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            let controlPointTemp = controlPointsTemp[controlPointIndex]
            controlPointTemp.read(controlPoint)
        }
        
        for controlPointIndex in 0..<controlPointCount {
            let controlPointTemp = controlPointsTemp[controlPointIndex]
            
            controlPointTemp.normalizedX = (1.0 - controlPointTemp.normalizedX)
            controlPointTemp.isManualPositionEnabled = true
            
            var normalizedTanDirection = controlPointTemp.normalizedTanDirection
            normalizedTanDirection = fmodf(normalizedTanDirection, Math.pi2)
            if normalizedTanDirection > Math.pi {
                normalizedTanDirection -= Math.pi2
            }
            let tanRotationSwivel = Math.pi_2 - normalizedTanDirection
            controlPointTemp.normalizedTanDirection = Math.pi_2 + tanRotationSwivel
            controlPointTemp.isManualTanHandleEnabled = true
            
            let hold = controlPointTemp.normalizedTanMagnitudeIn
            controlPointTemp.normalizedTanMagnitudeIn = controlPointTemp.normalizedTanMagnitudeOut
            controlPointTemp.normalizedTanMagnitudeOut = hold
        }
        
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointCount - controlPointIndex - 1]
            let controlPointTemp = controlPointsTemp[controlPointIndex]
            controlPoint.read(controlPointTemp)
        }
    }
    
    public func invertV(frameWidth: Float,
                        frameHeight: Float,
                        paddingH: Float,
                        paddingV: Float) {
        
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            let controlPointTemp = controlPointsTemp[controlPointIndex]
            controlPointTemp.read(controlPoint)
        }
        
        var minY = Float(1.0)
        var maxY = Float(0.0)
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            minY = min(minY, controlPoint.normalizedY)
            maxY = max(maxY, controlPoint.normalizedY)
        }
        
        let rangeY = maxY - minY
        if rangeY > Math.epsilon {
            
            for controlPointIndex in 0..<controlPointCount {
                let controlPointTemp = controlPointsTemp[controlPointIndex]
                
                var percentY = (controlPointTemp.normalizedY - minY) / rangeY
                percentY = (1.0 - percentY)
                controlPointTemp.normalizedY = minY + rangeY * percentY
                controlPointTemp.isManualPositionEnabled = true
                
                var normalizedTanDirection = controlPointTemp.normalizedTanDirection
                normalizedTanDirection = fmodf(normalizedTanDirection, Math.pi2)
                if normalizedTanDirection > Math.pi {
                    normalizedTanDirection -= Math.pi2
                }
                let tanRotationSwivel = Math.pi_2 - normalizedTanDirection
                controlPointTemp.normalizedTanDirection = Math.pi_2 + tanRotationSwivel
                controlPointTemp.isManualTanHandleEnabled = true
            }
            
            for controlPointIndex in 0..<controlPointCount {
                let controlPoint = controlPoints[controlPointIndex]
                let controlPointTemp = controlPointsTemp[controlPointIndex]
                controlPoint.read(controlPointTemp)
            }
        }
    }
    
    public func flipVertical(frameWidth: Float,
                             frameHeight: Float,
                             paddingH: Float,
                             paddingV: Float) {
        
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            let controlPointTemp = controlPointsTemp[controlPointIndex]
            controlPointTemp.read(controlPoint)
        }
        
        for controlPointIndex in 0..<controlPointCount {
            let controlPointTemp = controlPointsTemp[controlPointIndex]
            
            controlPointTemp.normalizedY = (1.0 - controlPointTemp.normalizedY)
            controlPointTemp.isManualPositionEnabled = true
            
            var normalizedTanDirection = controlPointTemp.normalizedTanDirection
            normalizedTanDirection = fmodf(normalizedTanDirection, Math.pi2)
            if normalizedTanDirection > Math.pi {
                normalizedTanDirection -= Math.pi2
            }
            let tanRotationSwivel = Math.pi_2 - normalizedTanDirection
            controlPointTemp.normalizedTanDirection = Math.pi_2 + tanRotationSwivel
            controlPointTemp.isManualTanHandleEnabled = true
        }
        
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            let controlPointTemp = controlPointsTemp[controlPointIndex]
            controlPoint.read(controlPointTemp)
        }
    }
    
    public func flipHorizontal(frameWidth: Float,
                               frameHeight: Float,
                               paddingH: Float,
                               paddingV: Float) {
        invertH(frameWidth: frameWidth,
                frameHeight: frameHeight,
                paddingH: paddingH,
                paddingV: paddingV)
    }
    
    public func resetDefaultAll() {
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            controlPoint.isManualPositionEnabled = false
            controlPoint.isManualTanHandleEnabled = false
        }
    }
    
    private func applyDefaultTypeCurve(izBig: Bool,
                                       tanFactorTimeLine: Float) {
        
        mudgeSpline.removeAll(keepingCapacity: true)
        
        if izBig {
            mudgeSpline.addControlPoint(-1.0, Self.defaultMinimimYLarge) // 0
            mudgeSpline.addControlPoint(-0.5, Self.defaultMaximumYLarge) // 1
            mudgeSpline.addControlPoint(0.0, Self.defaultMinimimYLarge)  // 2
            mudgeSpline.addControlPoint(0.5, Self.defaultMaximumYLarge)  // 3
            mudgeSpline.addControlPoint(1.0, Self.defaultMinimimYLarge)  // 4
            mudgeSpline.addControlPoint(1.5, Self.defaultMaximumYLarge)  // 5
            mudgeSpline.addControlPoint(2.0, Self.defaultMinimimYLarge)  // 6
        } else {
            mudgeSpline.addControlPoint(-1.0, Self.defaultMinimimYSmall) // 0
            mudgeSpline.addControlPoint(-0.5, Self.defaultMaximumYSmall) // 1
            mudgeSpline.addControlPoint(0.0, Self.defaultMinimimYSmall)  // 2
            mudgeSpline.addControlPoint(0.5, Self.defaultMaximumYSmall)  // 3
            mudgeSpline.addControlPoint(1.0, Self.defaultMinimimYSmall)  // 4
            mudgeSpline.addControlPoint(1.5, Self.defaultMaximumYSmall)  // 5
            mudgeSpline.addControlPoint(2.0, Self.defaultMinimimYSmall)  // 6
        }
        
        let tanLengthX = Float(0.5)
        
        mudgeSpline.enableManualControlTanIn(at: 0, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 0, outTanX: tanLengthX, outTanY: 0.0)
        
        mudgeSpline.enableManualControlTanIn(at: 1, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 1, outTanX: tanLengthX, outTanY: 0.0)
        
        mudgeSpline.enableManualControlTanIn(at: 2, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 2, outTanX: tanLengthX, outTanY: 0.0)
        
        mudgeSpline.enableManualControlTanIn(at: 3, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 3, outTanX: tanLengthX, outTanY: 0.0)
        
        mudgeSpline.enableManualControlTanIn(at: 4, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 4, outTanX: tanLengthX, outTanY: 0.0)
        
        mudgeSpline.enableManualControlTanIn(at: 5, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 5, outTanX: tanLengthX, outTanY: 0.0)
        
        mudgeSpline.enableManualControlTanIn(at: 6, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 6, outTanX: tanLengthX, outTanY: 0.0)
        
        mudgeSpline.solve(closed: false)
        
        applyDefaultTypeWithMudgeSpline(tanFactorTimeLine: tanFactorTimeLine)
    }
    
    private func applyDefaultTypeDivot(izBig: Bool,
                                       tanFactorTimeLine: Float) {
        
        mudgeSpline.removeAll(keepingCapacity: true)
        
        if izBig {
            mudgeSpline.addControlPoint(-1.0, 0.5) // 0
            mudgeSpline.addControlPoint(-0.5, Self.defaultMinimimYLarge) // 1
            mudgeSpline.addControlPoint(0.0, 0.5)  // 2
            mudgeSpline.addControlPoint(0.5, Self.defaultMinimimYLarge)  // 3
            mudgeSpline.addControlPoint(1.0, 0.5)  // 4
            mudgeSpline.addControlPoint(1.5, Self.defaultMinimimYLarge)  // 5
            mudgeSpline.addControlPoint(2.0, 0.5)  // 6
        } else {
            mudgeSpline.addControlPoint(-1.0, 0.5) // 0
            mudgeSpline.addControlPoint(-0.5, Self.defaultMinimimYSmall) // 1
            mudgeSpline.addControlPoint(0.0, 0.5)  // 2
            mudgeSpline.addControlPoint(0.5, Self.defaultMinimimYSmall)  // 3
            mudgeSpline.addControlPoint(1.0, 0.5)  // 4
            mudgeSpline.addControlPoint(1.5, Self.defaultMinimimYSmall)  // 5
            mudgeSpline.addControlPoint(2.0, 0.5)  // 6
        }
        
        let tanLengthX = Float(0.5)
        
        mudgeSpline.enableManualControlTanIn(at: 0, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 0, outTanX: tanLengthX, outTanY: 0.0)
        
        mudgeSpline.enableManualControlTanIn(at: 1, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 1, outTanX: tanLengthX, outTanY: 0.0)
        
        mudgeSpline.enableManualControlTanIn(at: 2, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 2, outTanX: tanLengthX, outTanY: 0.0)
        
        mudgeSpline.enableManualControlTanIn(at: 3, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 3,  outTanX: tanLengthX, outTanY: 0.0)
        
        mudgeSpline.enableManualControlTanIn(at: 4, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 4, outTanX: tanLengthX, outTanY: 0.0)
        
        mudgeSpline.enableManualControlTanIn(at: 5, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 5, outTanX: tanLengthX, outTanY: 0.0)
        
        mudgeSpline.enableManualControlTanIn(at: 6, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 6, outTanX: tanLengthX, outTanY: 0.0)
        
        mudgeSpline.solve(closed: false)
        
        applyDefaultTypeWithMudgeSpline(tanFactorTimeLine: tanFactorTimeLine)
    }
    
    private func applyDefaultTypeSwan(tanFactorTimeLine: Float) {
        
        mudgeSpline.removeAll(keepingCapacity: true)
        
        mudgeSpline.addControlPoint(-1.0, Self.defaultMaximumYSmall) // 0
        mudgeSpline.addControlPoint(-0.5, Self.defaultMinimimYLarge) // 1
        mudgeSpline.addControlPoint(0.0, Self.defaultMaximumYSmall)  // 2
        mudgeSpline.addControlPoint(0.5, Self.defaultMinimimYLarge)  // 3
        mudgeSpline.addControlPoint(1.0, Self.defaultMaximumYSmall)  // 4
        mudgeSpline.addControlPoint(1.5, Self.defaultMinimimYLarge)  // 5
        mudgeSpline.addControlPoint(2.0, Self.defaultMaximumYSmall)  // 6
        
        let tanLengthX = Float(0.5)
        
        mudgeSpline.enableManualControlTanIn(at: 0, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 0, outTanX: tanLengthX, outTanY: 0.0)
        mudgeSpline.enableManualControlTanIn(at: 1, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 1, outTanX: tanLengthX, outTanY: 0.0)
        mudgeSpline.enableManualControlTanIn(at: 2, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 2, outTanX: tanLengthX, outTanY: 0.0)
        mudgeSpline.enableManualControlTanIn(at: 3, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 3, outTanX: tanLengthX, outTanY: 0.0)
        mudgeSpline.enableManualControlTanIn(at: 4, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 4, outTanX: tanLengthX, outTanY: 0.0)
        mudgeSpline.enableManualControlTanIn(at: 5, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 5, outTanX: tanLengthX, outTanY: 0.0)
        mudgeSpline.enableManualControlTanIn(at: 6, inTanX: -tanLengthX, inTanY: 0.0)
        mudgeSpline.enableManualControlTanOut(at: 6, outTanX: tanLengthX, outTanY: 0.0)
        
        mudgeSpline.solve(closed: false)
        
        applyDefaultTypeWithMudgeSpline(tanFactorTimeLine: tanFactorTimeLine)
    }
    
    private func applyDefaultTypeWithMudgeSpline(tanFactorTimeLine: Float) {
        
        let controlPointCount1 = (controlPointCount - 1)
        let controlPointCount1f = Float(controlPointCount1)
        
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            let percent = Float(controlPointIndex) / controlPointCount1f
            let splinePosition = percent * 2.0 + Float(2.0)
            if controlPoint.isManualPositionEnabled == false {
                controlPoint.normalizedX = mudgeSpline.getX(splinePosition)
                controlPoint.normalizedY = mudgeSpline.getY(splinePosition)
            }
        }
        
        healSpline.removeAll(keepingCapacity: true)
        
        var _controlPointIndex = 0
        
        while _controlPointIndex < controlPointCount1 {
            let controlPoint = controlPoints[_controlPointIndex]
            healSpline.addControlPoint(controlPoint.normalizedX - 2.0, controlPoint.normalizedY)
            _controlPointIndex += 1
        }
        _controlPointIndex = 0
        while _controlPointIndex < controlPointCount1 {
            let controlPoint = controlPoints[_controlPointIndex]
            healSpline.addControlPoint(controlPoint.normalizedX - 1.0, controlPoint.normalizedY)
            _controlPointIndex += 1
        }
        _controlPointIndex = 0
        while _controlPointIndex < controlPointCount {
            let controlPoint = controlPoints[_controlPointIndex]
            healSpline.addControlPoint(controlPoint.normalizedX, controlPoint.normalizedY)
            _controlPointIndex += 1
        }
        _controlPointIndex = 1
        while _controlPointIndex < controlPointCount {
            let controlPoint = controlPoints[_controlPointIndex]
            healSpline.addControlPoint(controlPoint.normalizedX + 1.0, controlPoint.normalizedY)
            _controlPointIndex += 1
        }
        _controlPointIndex = 1
        while _controlPointIndex < controlPointCount {
            let controlPoint = controlPoints[_controlPointIndex]
            healSpline.addControlPoint(controlPoint.normalizedX + 2.0, controlPoint.normalizedY)
            _controlPointIndex += 1
        }
        
        for index in 0..<healSpline.count {
            healSpline.disableManualControlTanIn(at: index)
            healSpline.disableManualControlTanOut(at: index)
        }
        
        var healSplineIndex = 0
        while _controlPointIndex < controlPointCount1 {
            let controlPoint = controlPoints[_controlPointIndex]
            
            if controlPoint.isManualTanHandleEnabled {
                
                let magnitudeIn = controlPoint.normalizedTanMagnitudeIn / tanFactorTimeLine
                let magnitudeOut = controlPoint.normalizedTanMagnitudeOut / tanFactorTimeLine
                
                let dirX = sinf(controlPoint.normalizedTanDirection)
                let dirY = -cosf(controlPoint.normalizedTanDirection)
                
                healSpline.enableManualControlTanIn(at: healSplineIndex,
                                                  inTanX: -dirX * magnitudeIn,
                                                  inTanY: -dirY * magnitudeIn)
                healSpline.enableManualControlTanOut(at: healSplineIndex,
                                                  outTanX: dirX * magnitudeOut,
                                                  outTanY: dirY * magnitudeOut)
            }
            
            healSplineIndex += 1
            _controlPointIndex += 1
        }
        
        healSplineIndex = 0
        while _controlPointIndex < controlPointCount1 {
            let controlPoint = controlPoints[_controlPointIndex]
            
            if controlPoint.isManualTanHandleEnabled {
                
                let magnitudeIn = controlPoint.normalizedTanMagnitudeIn / tanFactorTimeLine
                let magnitudeOut = controlPoint.normalizedTanMagnitudeOut / tanFactorTimeLine
                
                let dirX = sinf(controlPoint.normalizedTanDirection)
                let dirY = -cosf(controlPoint.normalizedTanDirection)
                
                healSpline.enableManualControlTanIn(at: healSplineIndex,
                                                  inTanX: -dirX * magnitudeIn,
                                                  inTanY: -dirY * magnitudeIn)
                healSpline.enableManualControlTanOut(at: healSplineIndex,
                                                  outTanX: dirX * magnitudeOut,
                                                  outTanY: dirY * magnitudeOut)
            }
            
            healSplineIndex += 1
            _controlPointIndex += 1
        }
        
        _controlPointIndex = 0
        while _controlPointIndex < controlPointCount {
            let controlPoint = controlPoints[_controlPointIndex]
            
            if controlPoint.isManualTanHandleEnabled {
                
                let magnitudeIn = controlPoint.normalizedTanMagnitudeIn / tanFactorTimeLine
                let magnitudeOut = controlPoint.normalizedTanMagnitudeOut / tanFactorTimeLine
                
                let dirX = sinf(controlPoint.normalizedTanDirection)
                let dirY = -cosf(controlPoint.normalizedTanDirection)
                
                healSpline.enableManualControlTanIn(at: healSplineIndex,
                                                  inTanX: -dirX * magnitudeIn,
                                                  inTanY: -dirY * magnitudeIn)
                healSpline.enableManualControlTanOut(at: healSplineIndex,
                                                  outTanX: dirX * magnitudeOut,
                                                  outTanY: dirY * magnitudeOut)
            }
            
            healSplineIndex += 1
            _controlPointIndex += 1
        }
        _controlPointIndex = 1
        while _controlPointIndex < controlPointCount {
            let controlPoint = controlPoints[_controlPointIndex]
            
            if controlPoint.isManualTanHandleEnabled {
                
                let magnitudeIn = controlPoint.normalizedTanMagnitudeIn / tanFactorTimeLine
                let magnitudeOut = controlPoint.normalizedTanMagnitudeOut / tanFactorTimeLine
                
                let dirX = sinf(controlPoint.normalizedTanDirection)
                let dirY = -cosf(controlPoint.normalizedTanDirection)
                
                healSpline.enableManualControlTanIn(at: healSplineIndex,
                                                  inTanX: -dirX * magnitudeIn,
                                                  inTanY: -dirY * magnitudeIn)
                healSpline.enableManualControlTanOut(at: healSplineIndex,
                                                  outTanX: dirX * magnitudeOut,
                                                  outTanY: dirY * magnitudeOut)
            }
            
            healSplineIndex += 1
            _controlPointIndex += 1
        }
        
        _controlPointIndex = 1
        while _controlPointIndex < controlPointCount {
            let controlPoint = controlPoints[_controlPointIndex]
            
            if controlPoint.isManualTanHandleEnabled {
                
                let magnitudeIn = controlPoint.normalizedTanMagnitudeIn / tanFactorTimeLine
                let magnitudeOut = controlPoint.normalizedTanMagnitudeOut / tanFactorTimeLine
                
                let dirX = sinf(controlPoint.normalizedTanDirection)
                let dirY = -cosf(controlPoint.normalizedTanDirection)
                
                healSpline.enableManualControlTanIn(at: healSplineIndex,
                                                  inTanX: -dirX * magnitudeIn,
                                                  inTanY: -dirY * magnitudeIn)
                healSpline.enableManualControlTanOut(at: healSplineIndex,
                                                  outTanX: dirX * magnitudeOut,
                                                  outTanY: dirY * magnitudeOut)
            }
            
            healSplineIndex += 1
            _controlPointIndex += 1
        }
        
        healSpline.solve(closed: false)
        
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            if controlPoint.isManualTanHandleEnabled == false {
                
                let splinePosition = Float(controlPointCount + controlPointCount + controlPointIndex - 2)
                
                let outTanX = healSpline.getTanX(splinePosition)
                let outTanY = -healSpline.getTanY(splinePosition)
                
                let inTanX = -outTanX
                let inTanY = -outTanY
                
                var inDist = inTanX * inTanX + inTanY * inTanY
                var outDist = outTanX * outTanX + outTanY * outTanY
                
                let epsilon1 = Float(32.0 * 32.0)
                let epsilon2 = Float( 4.0 *  4.0)
                let epsilon3 = Float(0.1 * 0.1)
                
                var rotation = Float(0.0)
                var isValidReading = true
                
                if inDist > epsilon1 {
                    rotation = Math.face(target: .init(x: -inTanX, y: -inTanY))
                } else if outDist > epsilon1 {
                    rotation = Math.face(target: .init(x: outTanX, y: outTanY))
                } else if inDist > epsilon2 {
                    rotation = Math.face(target: .init(x: -inTanX, y: -inTanY))
                } else if outDist > epsilon2 {
                    rotation = Math.face(target: .init(x: outTanX, y: outTanY))
                } else if inDist > epsilon3 {
                    rotation = Math.face(target: .init(x: -inTanX, y: -inTanY))
                } else if outDist > epsilon3 {
                    rotation = Math.face(target: .init(x: outTanX, y: outTanY))
                } else {
                    isValidReading = false
                }
                
                if inDist > Math.epsilon {
                    inDist = sqrtf(inDist)
                }
                
                if outDist > Math.epsilon {
                    outDist = sqrtf(outDist)
                }
                
                if isValidReading {
                    controlPoint.normalizedTanDirection = rotation
                    controlPoint.normalizedTanMagnitudeIn = inDist * tanFactorTimeLine
                    controlPoint.normalizedTanMagnitudeOut = outDist * tanFactorTimeLine
                }
            }
        }
    }
    
    func applyDefaultType(frameWidth: Float,
                          frameHeight: Float,
                          paddingH: Float,
                          paddingV: Float,
                          tanFactorTimeLine: Float) {
        
        guard controlPointCount >= 3 else {
            return
        }
        
        let controlPointCount1 = (controlPointCount - 1)
        let controlPointCount1f = Float(controlPointCount1)

        switch defaultType {
        case .flat:
            for controlPointIndex in 0..<controlPointCount {
                let controlPoint = controlPoints[controlPointIndex]
                
                var percentCurrent = Float(1.0)
                if controlPointCount1 > 0 {
                    percentCurrent = Float(controlPointIndex) / controlPointCount1f
                }
                
                if !controlPoint.isManualPositionEnabled {
                    controlPoint.normalizedX = percentCurrent
                    controlPoint.normalizedY = 0.5
                }
                
                if !controlPoint.isManualTanHandleEnabled {
                    controlPoints[controlPointIndex].normalizedTanDirection = Math.pi_2
                    
                    if controlPointIndex > 0 {
                        let percentPrevious = Float(controlPointIndex - 1) / controlPointCount1f
                        let difference = (percentCurrent - percentPrevious)
                        controlPoints[controlPointIndex].normalizedTanMagnitudeIn = (difference) * 0.375
                    }
                    
                    if controlPointIndex < controlPointCount1 {
                        let percentNext = Float(controlPointIndex + 1) / controlPointCount1f
                        let difference = (percentNext - percentCurrent)
                        controlPoints[controlPointIndex].normalizedTanMagnitudeOut = (difference) * 0.375
                    }
                }
            }
        case .curve:
            applyDefaultTypeCurve(izBig: true,
                                  tanFactorTimeLine: tanFactorTimeLine)
        case .curveSmall:
            applyDefaultTypeCurve(izBig: false,
                                  tanFactorTimeLine: tanFactorTimeLine)
            
        case .divot:
            applyDefaultTypeDivot(izBig: true,
                                  tanFactorTimeLine: tanFactorTimeLine)
        case .divotSmall:
            applyDefaultTypeDivot(izBig: false,
                                  tanFactorTimeLine: tanFactorTimeLine)
        case .swan:
            applyDefaultTypeSwan(tanFactorTimeLine: tanFactorTimeLine)
        }
        
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            controlPoint.isManualTanHandleEnabled = true
            controlPoint.isManualPositionEnabled = true
        }
    }
    
    public func resetCurve(frameWidth: Float,
                           frameHeight: Float,
                           paddingH: Float,
                           paddingV: Float,
                           tanFactorTimeLine: Float) {
        resetDefaultAll()
        defaultType = .curve
        applyDefaultType(frameWidth: frameWidth,
                         frameHeight: frameHeight,
                         paddingH: paddingH,
                         paddingV: paddingV,
                         tanFactorTimeLine: tanFactorTimeLine)
    }
    
    public func resetCurveSmall(frameWidth: Float,
                                frameHeight: Float,
                                paddingH: Float,
                                paddingV: Float,
                                tanFactorTimeLine: Float) {
        resetDefaultAll()
        defaultType = .curveSmall
        applyDefaultType(frameWidth: frameWidth,
                         frameHeight: frameHeight,
                         paddingH: paddingH,
                         paddingV: paddingV,
                         tanFactorTimeLine: tanFactorTimeLine)
    }
    
    public func resetDivot(frameWidth: Float,
                           frameHeight: Float,
                           paddingH: Float,
                           paddingV: Float,
                           tanFactorTimeLine: Float) {
        resetDefaultAll()
        defaultType = .divot
        applyDefaultType(frameWidth: frameWidth,
                         frameHeight: frameHeight,
                         paddingH: paddingH,
                         paddingV: paddingV,
                         tanFactorTimeLine: tanFactorTimeLine)
    }
    
    public func resetDivotSmall(frameWidth: Float,
                                frameHeight: Float,
                                paddingH: Float,
                                paddingV: Float,
                                tanFactorTimeLine: Float) {
        resetDefaultAll()
        defaultType = .divotSmall
        applyDefaultType(frameWidth: frameWidth,
                         frameHeight: frameHeight,
                         paddingH: paddingH,
                         paddingV: paddingV,
                         tanFactorTimeLine: tanFactorTimeLine)
    }
    
    public func resetFlat(frameWidth: Float,
                          frameHeight: Float,
                          paddingH: Float,
                          paddingV: Float,
                          tanFactorTimeLine: Float) {
        resetDefaultAll()
        defaultType = .flat
        applyDefaultType(frameWidth: frameWidth,
                         frameHeight: frameHeight,
                         paddingH: paddingH,
                         paddingV: paddingV,
                         tanFactorTimeLine: tanFactorTimeLine)
    }
    
    public func resetSwan(frameWidth: Float,
                          frameHeight: Float,
                          paddingH: Float,
                          paddingV: Float,
                          tanFactorTimeLine: Float) {
        resetDefaultAll()
        defaultType = .swan
        applyDefaultType(frameWidth: frameWidth,
                         frameHeight: frameHeight,
                         paddingH: paddingH,
                         paddingV: paddingV,
                         tanFactorTimeLine: tanFactorTimeLine)
    }
    
    public func timeLineShiftDown(frameWidth: Float,
                                  frameHeight: Float,
                                  paddingH: Float,
                                  paddingV: Float) {
        
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            controlPoint.normalizedY -= 0.05
            if controlPoint.normalizedY < 0.0 {
                controlPoint.normalizedY = 0.0
            }
            controlPoint.isManualPositionEnabled = true
        }
    }
    
    public func timeLineShiftUp(frameWidth: Float,
                                frameHeight: Float,
                                paddingH: Float,
                                paddingV: Float) {
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            controlPoint.normalizedY += 0.05
            if controlPoint.normalizedY > 1.0 {
                controlPoint.normalizedY = 1.0
            }
            controlPoint.isManualPositionEnabled = true
        }
    }
    
    private func selectAnyControlPoint() {
        if selectedControlIndex >= controlPointCount {
            selectedControlIndex = controlPointCount - 1
        }
        if selectedControlIndex < 0 {
            selectedControlIndex = 0
        }
    }
    
    public func read(_ channel: TimeLineChannel) {
        
        defaultType = channel.defaultType
        
        let controlPointCeiling = min(controlPointCount, channel.controlPointCount)
        var controlPointIndex = 0
        while controlPointIndex < controlPointCeiling {
            controlPoints[controlPointIndex].read(channel.controlPoints[controlPointIndex])
            controlPointIndex += 1
        }
    }
    
    static let SAMPEL_COUNTASZ = 256
    static let NUMBER_OF_BUCKETZ = 24
    static let BUCKETZ_EPZILON = Float(64.0)
    
    var buckets = [TimeLineSegmentBucket]()
    
    let tempBucket = TimeLineSegmentBucket(startX: 0.0, endX: 0.0)
    
    var tempPrecomputedLineSegments = [AnyPrecomputedLineSegment]()
    var tempPrecomputedLineSegmentCount = 0
    func addTempPrecomputedLineSegment(x1: Float, y1: Float,
                                       x2: Float, y2: Float) {
        let precomputedLineSegment = TimeLinePartsFactory.shared.withdrawPrecomputedLineSegment()
        precomputedLineSegment.x1 = x1
        precomputedLineSegment.y1 = y1
        precomputedLineSegment.x2 = x2
        precomputedLineSegment.y2 = y2
        addTempPrecomputedLineSegment(precomputedLineSegment)
    }
    
    func addTempPrecomputedLineSegment(_ precomputedLineSegment: AnyPrecomputedLineSegment) {
        while tempPrecomputedLineSegments.count <= tempPrecomputedLineSegmentCount {
            tempPrecomputedLineSegments.append(precomputedLineSegment)
        }
        tempPrecomputedLineSegments[tempPrecomputedLineSegmentCount] = precomputedLineSegment
        tempPrecomputedLineSegmentCount += 1
        
        precomputedLineSegment.precompute()
    }
    
    public func purgeTempPrecomputedLineSegments() {
        for precomputedLineSegmentIndex in 0..<tempPrecomputedLineSegmentCount {
            let precomputedLineSegment = tempPrecomputedLineSegments[precomputedLineSegmentIndex]
            TimeLinePartsFactory.shared.depositPrecomputedLineSegment(precomputedLineSegment)
        }
        tempPrecomputedLineSegmentCount = 0
    }
    
    public let spline = FancySpline()
    let mudgeSpline = FancySpline()
    let healSpline = FancySpline()
    
    public func getSelectedControlPoint() -> TimeLineControlPoint? {
        if selectedControlIndex >= 0 && selectedControlIndex < controlPointCount {
            return controlPoints[selectedControlIndex]
        }
        return nil
    }
    
    public var selectedControlIndex = -1
    public func switchSelectedControlIndex(index: Int) {
        selectedControlIndex = index
    }
    
    func getControlPointIndex(controlPoint: TimeLineControlPoint) -> Int? {
        for controlPointIndex in 0..<controlPointCount {
            if controlPoints[controlPointIndex] === controlPoint {
                return controlPointIndex
            }
        }
        return nil
    }
    
    public func buildSplineFromCurve(frameWidth: Float,
                                     frameHeight: Float,
                                     paddingH: Float,
                                     paddingV: Float,
                                     tanFactorTimeLine: Float) {
        applyDefaultType(frameWidth: frameWidth,
                         frameHeight: frameHeight,
                         paddingH: paddingH,
                         paddingV: paddingV,
                         tanFactorTimeLine: tanFactorTimeLine)
    }
    
    public func refreshSpline(frameWidth: Float,
                              frameHeight: Float,
                              paddingH: Float,
                              paddingV: Float,
                              tanFactorTimeLine: Float) {
        
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            controlPoint.tempY = (1.0 - controlPoint.normalizedY)
            controlPoint.tempX = controlPoint.normalizedX
        }
        
        spline.removeAll(keepingCapacity: true)
        
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = controlPoints[controlPointIndex]
            
            spline.addControlPoint(controlPoint.tempX,
                                   controlPoint.tempY)
            
            let magnitudeIn = controlPoint.normalizedTanMagnitudeIn / tanFactorTimeLine
            let magnitudeOut = controlPoint.normalizedTanMagnitudeOut / tanFactorTimeLine
            
            let dirX = sinf(controlPoint.normalizedTanDirection)
            let dirY = -cosf(controlPoint.normalizedTanDirection)
            
            spline.enableManualControlTanIn(at: controlPointIndex,
                                          inTanX: -dirX * magnitudeIn,
                                          inTanY: -dirY * magnitudeIn)
            spline.enableManualControlTanOut(at: controlPointIndex,
                                          outTanX: dirX * magnitudeOut,
                                          outTanY: dirY * magnitudeOut)
            
        }
        
        spline.solve(closed: false)
        
        buildOutSmoother()
        
    }
    
    func buildOutSmoother() {
        
        // Purge the line segments...
        purgeTempPrecomputedLineSegments()
        
        // Generate fresh line segments...
        var lastX = spline.getControlX(0) * TimeLineSmoother.SCALE
        var lastY = spline.getControlY(0) * TimeLineSmoother.SCALE
        
        let step = Float(0.05)
        var position = step
        while position < spline.maxPos {
            let x = spline.getX(position) * TimeLineSmoother.SCALE
            let y = spline.getY(position) * TimeLineSmoother.SCALE
            
            addTempPrecomputedLineSegment(x1: lastX, y1: lastY,
                                          x2: x, y2: y)
            lastX = x
            lastY = y
            
            position += step
        }
        
        let finalX = spline.getControlX(spline.count - 1) * TimeLineSmoother.SCALE
        let finalY = spline.getControlY(spline.count - 1) * TimeLineSmoother.SCALE
        
        addTempPrecomputedLineSegment(x1: lastX, y1: lastY,
                                      x2: finalX, y2: finalY)
        
        // Empty all da buckets...
        
        for bucketIndex in 0..<buckets.count {
            let bucket = buckets[bucketIndex]
            bucket.removeAll()
        }
        
        // Bucket the line segments...
        
        for tempPrecomputedLineSegmentIndex in 0..<tempPrecomputedLineSegmentCount {
            let tempPrecomputedLineSegment = tempPrecomputedLineSegments[tempPrecomputedLineSegmentIndex]
            
            for bucketIndex in 0..<buckets.count {
                let bucket = buckets[bucketIndex]
                if Math.rangesOverlap(start1: tempPrecomputedLineSegment.x1,
                                      end1: tempPrecomputedLineSegment.x2,
                                      start2: bucket.startX,
                                      end2: bucket.endX) {
                    bucket.add(tempPrecomputedLineSegment)
                }
            }
        }
        
        smoother.removeAll(keepingCapacity: true)
        
        if tempPrecomputedLineSegmentCount > 0 {
            smoother.addPoint(distance: 0.0,
                              value: tempPrecomputedLineSegments[0].y1)
        }
        
        for index in 1..<Self.SAMPEL_COUNTASZ {
            let percent = Float(index) / Float(Self.SAMPEL_COUNTASZ)
            let distance = percent * TimeLineSmoother.SCALE
            
            tempBucket.removeAll()
            
            for bucketIndex in 0..<buckets.count {
                let bucket = buckets[bucketIndex]
                
                if distance >= bucket.startX && distance <= bucket.endX {
                    
                    for bucketLineSegmentIndex in 0..<bucket.precomputedLineSegmentCount {
                        let bucketLineSegment = bucket.precomputedLineSegments[bucketLineSegmentIndex]
                        let minX = min(bucketLineSegment.x1, bucketLineSegment.x2)
                        let maxX = max(bucketLineSegment.x1, bucketLineSegment.x2)
                        if distance >= minX && distance <= maxX {
                            tempBucket.add(bucketLineSegment)
                        }
                        
                    }
                }
            }
            
            let rayOriginX = distance
            let rayOriginY = -(TimeLineSmoother.SCALE +
                               TimeLineSmoother.SCALE +
                               TimeLineSmoother.SCALE +
                               TimeLineSmoother.SCALE)
            
            let rayDestinationX = distance
            let rayDestinationY = (TimeLineSmoother.SCALE +
                                   TimeLineSmoother.SCALE +
                                   TimeLineSmoother.SCALE +
                                   TimeLineSmoother.SCALE +
                                   TimeLineSmoother.SCALE)
            
            var bestDistance = Float(100_000_000_000.0)
            
            let dirX = Float(0.0)
            let dirY = Float(1.0)
            
            var isRaySolutionValid = false
            var solutionY = Float(0.0)
            
            for tempBucketIndex in 0..<tempBucket.precomputedLineSegmentCount {
                let tempBucketLineSegment = tempBucket.precomputedLineSegments[tempBucketIndex]
                
                if Math.lineSegmentIntersectsLineSegment(line1Point1X: rayOriginX,
                                                         line1Point1Y: rayOriginY,
                                                         line1Point2X: rayDestinationX,
                                                         line1Point2Y: rayDestinationY,
                                                         line2Point1X: tempBucketLineSegment.x1,
                                                         line2Point1Y: tempBucketLineSegment.y1,
                                                         line2Point2X: tempBucketLineSegment.x2,
                                                         line2Point2Y: tempBucketLineSegment.y2) {
                    
                    let rayRayResult = Math.rayIntersectionRay(rayOrigin1X: tempBucketLineSegment.x1,
                                                               rayOrigin1Y: tempBucketLineSegment.y1,
                                                               rayNormal1X: tempBucketLineSegment.normalX,
                                                               rayNormal1Y: tempBucketLineSegment.normalY,
                                                               rayOrigin2X: rayOriginX,
                                                               rayOrigin2Y: rayOriginY,
                                                               rayDirection2X: dirX,
                                                               rayDirection2Y: dirY)
                    
                    switch rayRayResult {
                    case .invalidCoplanar:
                        break
                    case .valid(_ , pointY: let pointY, distance: let distance):
                        if distance < bestDistance {
                            bestDistance = distance
                            isRaySolutionValid = true
                            solutionY = pointY
                        }
                    }
                }
            }
            
            if isRaySolutionValid {
                smoother.addPoint(distance: distance,
                                  value: solutionY)
            }
            
        }
        
        if tempPrecomputedLineSegmentCount > 0 {
            smoother.addPoint(distance: TimeLineSmoother.SCALE,
                              value: tempPrecomputedLineSegments[tempPrecomputedLineSegmentCount - 1].y2)
        }
        
    }
    
    public func updateSelectedControlPointTanHandleIn(controlPoint: TimeLineControlPoint,
                                                      tanHandleX: Float,
                                                      tanHandleY: Float,
                                                      frameWidth: Float,
                                                      frameHeight: Float,
                                                      paddingH: Float,
                                                      paddingV: Float) {
        
        let width = (frameWidth - paddingH - paddingH)
        let height = (frameHeight - paddingV - paddingV)
        
        if width > Math.epsilon && height > Math.epsilon {
            
            //let handleX = (tanHandleX / (width)) / splineFactorX
            let handleX = (tanHandleX / (width))
            let handleY = tanHandleY / height
            
            let magnitudeSquared = handleX * handleX + handleY * handleY
            if magnitudeSquared > Math.epsilon {
                let magnitude = sqrtf(magnitudeSquared)
                controlPoint.normalizedTanDirection = -atan2f(handleX, handleY)
                controlPoint.normalizedTanMagnitudeIn = magnitude
                controlPoint.isManualTanHandleEnabled = true
                
                if let controlPointIndex = getControlPointIndex(controlPoint: controlPoint) {
                    let controlPointCount1 = controlPointCount - 1
                    if controlPointIndex == controlPointCount1 {
                        controlPoints[0].normalizedTanDirection = controlPoint.normalizedTanDirection
                        controlPoints[0].isManualTanHandleEnabled = true
                    }
                }
            }
        }
    }
    
    public func updateSelectedControlPointTanHandleOut(controlPoint: TimeLineControlPoint,
                                                       tanHandleX: Float,
                                                       tanHandleY: Float,
                                                       frameWidth: Float,
                                                       frameHeight: Float,
                                                       paddingH: Float,
                                                       paddingV: Float) {
        
        let width = (frameWidth - paddingH - paddingH)
        let height = (frameHeight - paddingV - paddingV)
        
        if width > Math.epsilon && height > Math.epsilon {
            //let handleX = (tanHandleX / (width)) / splineFactorX
            let handleX = (tanHandleX / (width))
            
            let handleY = tanHandleY / height
            let magnitudeSquared = handleX * handleX + handleY * handleY
            if magnitudeSquared > Math.epsilon {
                let magnitude = sqrtf(magnitudeSquared)
                controlPoint.normalizedTanDirection = -atan2f(-handleX, -handleY)
                controlPoint.normalizedTanMagnitudeOut = magnitude
                controlPoint.isManualTanHandleEnabled = true
                
                if let controlPointIndex = getControlPointIndex(controlPoint: controlPoint) {
                    let controlPointCount1 = controlPointCount - 1
                    if controlPointIndex == 0 {
                        controlPoints[controlPointCount1].normalizedTanDirection = controlPoint.normalizedTanDirection
                        controlPoints[controlPointCount1].isManualTanHandleEnabled = true
                        
                    }
                }
            }
        }
    }
}
