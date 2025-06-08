//
//  WeightCurve.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 3/4/24.
//
//  Not Verified, Heavily Changed
//

import Foundation

public class WeightCurve {
    
    public var resetType = WeightCurveResetType.linear2
    
    static let scale = Float(2048.0)
    
    public let spline = FancySpline()
    public let mapper = WeightCurveMapper()
    
    public var frameWidth = Float(0.0)
    public var frameHeight = Float(0.0)
    
    public var paddingH = Float(16.0)
    public var paddingV = Float(8.0)
    
    public var minX = Float(0.0)
    public var maxX = Float(0.0)
    public var minY = Float(0.0)
    public var maxY = Float(0.0)
    public var rangeX = Float(0.0)
    public var rangeY = Float(0.0)
    
    private let mudgeSpline = FancySpline()
    
    public init() {
        
    }
    
    public func buildSplineFromCurve(graphFrame: GraphFrame,
                                     tanFactorWeightCurve: Float,
                                     tanFactorWeightCurveAuto: Float,
                                     weightCurvePointStart: WeightCurvePoint,
                                     weightCurvePointMiddle: WeightCurvePoint,
                                     weightCurvePointEnd: WeightCurvePoint) {
        
        self.paddingH = graphFrame.paddingH
        self.paddingV = graphFrame.paddingV
        
        resetWeightCurvePoints()
        
        let minX = paddingH
        let maxX = graphFrame.width - graphFrame.paddingH
        let minY = graphFrame.paddingV
        let maxY = graphFrame.height - graphFrame.paddingV
        let rangeX = (maxX - minX)
        let rangeY = (maxY - minY)
        
        self.frameWidth = graphFrame.width
        self.frameHeight = graphFrame.height
        
        self.minX = minX
        self.maxX = maxX
        self.minY = minY
        self.maxY = maxY
        
        self.rangeX = rangeX
        self.rangeY = rangeY
        
        addWeightCurvePoint(weightCurvePointStart)
        addWeightCurvePoint(weightCurvePointMiddle)
        addWeightCurvePoint(weightCurvePointEnd)
        
        switch resetType {
        case .standard3:
            _boneOutTempY_Standard(factor: 1.0)
            _interpolateHeights()
        case .standard2:
            _boneOutTempY_Standard(factor: 0.75)
            _interpolateHeights()
        case .standard1:
            _boneOutTempY_Standard(factor: 0.5)
            _interpolateHeights()
        case .inverse3:
            _boneOutTempY_Inverse(factor: 1.0)
            _interpolateHeights()
        case .inverse2:
            _boneOutTempY_Inverse(factor: 0.75)
            _interpolateHeights()
        case .inverse1:
            _boneOutTempY_Inverse(factor: 0.5)
            _interpolateHeights()
        case .linear1:
            _boneOutTempY_Linear(factor: 0.5)
            _interpolateHeights()
        case .linear2:
            _boneOutTempY_Linear(factor: 0.75)
            _interpolateHeights()
        case .linear3:
            _boneOutTempY_Linear(factor: 1.0)
            _interpolateHeights()
        }
        
        _pickleRotationAll(tanFactorWeightCurve: tanFactorWeightCurve,
                           tanFactorWeightCurveAuto: tanFactorWeightCurveAuto)
        
    }
    
    private func _pickleRotationAll(tanFactorWeightCurve: Float, tanFactorWeightCurveAuto: Float) {
        mudgeSpline.removeAll(keepingCapacity: true)
        
        for weightCurvePointIndex in 0..<weightCurvePointCount {
            let weightCurvePoint = weightCurvePoints[weightCurvePointIndex]
            mudgeSpline.addControlPoint(Float(weightCurvePointIndex),
                                        (1.0 - weightCurvePoint.normalizedHeightFactor))
        }
        
        for weightCurvePointIndex in 0..<weightCurvePointCount {
            let weightCurvePoint = weightCurvePoints[weightCurvePointIndex]
            if weightCurvePoint.isManualTanHandleEnabled {
                
                let magnitudeIn = weightCurvePoint.normalizedTanMagnitudeIn / tanFactorWeightCurve
                let magnitudeOut = weightCurvePoint.normalizedTanMagnitudeOut / tanFactorWeightCurve
                
                let dirX = sinf(weightCurvePoint.normalizedTanDirection)
                let dirY = -cosf(weightCurvePoint.normalizedTanDirection)
                
                mudgeSpline.enableManualControlTanIn(at: weightCurvePointIndex,
                                                   inTanX: -dirX * magnitudeIn,
                                                   inTanY: -dirY * magnitudeIn)
                mudgeSpline.enableManualControlTanOut(at: weightCurvePointIndex,
                                                   outTanX: dirX * magnitudeOut,
                                                   outTanY: dirY * magnitudeOut)
            } else {
                mudgeSpline.disableManualControlTanIn(at: weightCurvePointIndex)
                mudgeSpline.disableManualControlTanOut(at: weightCurvePointIndex)
            }
        }
        
        mudgeSpline.solve(closed: false)
        
        let weightCurvePointCount1 = (weightCurvePointCount - 1)
        for weightCurvePointIndex in 0..<weightCurvePointCount {
            
            let weightCurvePoint = weightCurvePoints[weightCurvePointIndex]
            if !weightCurvePoint.isManualTanHandleEnabled {
                
                var inTanX = mudgeSpline.inTanX[weightCurvePointIndex]
                let inTanY = mudgeSpline.inTanY[weightCurvePointIndex]
                var outTanX = mudgeSpline.outTanX[weightCurvePointIndex]
                let outTanY = mudgeSpline.outTanY[weightCurvePointIndex]
                
                if weightCurvePointIndex == 0 {
                    if outTanX < 0.0 {
                        outTanX = 0.0
                    }
                    if inTanX > 0.0 {
                        inTanX = 0.0
                    }
                }
                if weightCurvePointIndex == weightCurvePointCount1 {
                    if outTanX < 0.0 {
                        outTanX = 0.0
                    }
                    if inTanX > 0.0 {
                        inTanX = 0.0
                    }
                }
                
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
                    if weightCurvePointIndex == 0 {
                        _pickleRotationDefaultLeftBookEnd(rotation: rotation,
                                                          outDist: outDist,
                                                          tanFactorWeightCurveAuto: tanFactorWeightCurveAuto)
                    } else if weightCurvePointIndex == (weightCurvePointCount - 1) {
                        _pickleRotationDefaultRightBookEnd(rotation: rotation,
                                                           inDist: inDist,
                                                           tanFactorWeightCurveAuto: tanFactorWeightCurveAuto)
                    } else {
                        _pickleRotationDefaultMiddle(index: weightCurvePointIndex,
                                                     rotation: rotation,
                                                     inDist: inDist,
                                                     outDist: outDist,
                                                     tanFactorWeightCurveAuto: tanFactorWeightCurveAuto)
                    }
                }
            }
        }
    }
    
    private func _pickleRotationDefaultLeftBookEnd(rotation: Float,
                                                   outDist: Float,
                                                   tanFactorWeightCurveAuto: Float) {
        if weightCurvePointCount > 0 {
            
            let weightCurvePoint = weightCurvePoints[0]
            
            switch resetType {
            case .standard3:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 0.42420724
                    weightCurvePoint.normalizedTanMagnitudeOut = 0.44
                    return
                }
            case .standard2:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 0.52564806
                    weightCurvePoint.normalizedTanMagnitudeOut = 0.4
                    return
                }
            case .standard1:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 0.72238183
                    weightCurvePoint.normalizedTanMagnitudeOut = 0.36
                    return
                }
            case .linear3:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 0.51950014
                    weightCurvePoint.normalizedTanMagnitudeOut = 0.44
                    return
                }
            case .linear2:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 0.6547546
                    weightCurvePoint.normalizedTanMagnitudeOut = 0.4
                    return
                }
            case .linear1:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 0.86071026
                    weightCurvePoint.normalizedTanMagnitudeOut = 0.36
                    return
                }
            case .inverse3:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 0.48876047
                    weightCurvePoint.normalizedTanMagnitudeOut = 0.36
                    return
                }
                if weightCurvePointCount == 3 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 0.91167784
                    weightCurvePoint.normalizedTanMagnitudeOut = 0.36
                    return
                }
            case .inverse2:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 0.69779015
                    weightCurvePoint.normalizedTanMagnitudeOut = 0.4
                    return
                }
                if weightCurvePointCount == 3 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 1.0656775
                    weightCurvePoint.normalizedTanMagnitudeOut = 0.4
                    return
                }
            case .inverse1:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 0.94985527
                    weightCurvePoint.normalizedTanMagnitudeOut = 0.44
                    return
                }
                if weightCurvePointCount == 3 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 1.2319971
                    weightCurvePoint.normalizedTanMagnitudeOut = 0.44
                    return
                }
            }
            weightCurvePoint.normalizedTanDirection = rotation
            weightCurvePoint.normalizedTanMagnitudeOut = outDist * tanFactorWeightCurveAuto * 3.0
        }
    }
    
    private func _pickleRotationDefaultRightBookEnd(rotation: Float,
                                                    inDist: Float,
                                                    tanFactorWeightCurveAuto: Float) {
        if weightCurvePointCount > 0 {
            let weightCurvePoint = weightCurvePoints[weightCurvePointCount - 1]
            switch resetType {
            case .standard3:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 1.5707963
                    weightCurvePoint.normalizedTanMagnitudeIn = 0.44
                    return
                }
            case .standard2:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 1.5707963
                    weightCurvePoint.normalizedTanMagnitudeIn = 0.4
                    return
                }
            case .standard1:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 1.5707963
                    weightCurvePoint.normalizedTanMagnitudeIn = 0.36
                    return
                }
            case .linear3:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 1.149663
                    weightCurvePoint.normalizedTanMagnitudeIn = 0.44
                    return
                }
            case .linear2:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 1.244956
                    weightCurvePoint.normalizedTanMagnitudeIn = 0.4
                    return
                }
            case .linear1:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 1.3494707
                    weightCurvePoint.normalizedTanMagnitudeIn = 0.36
                    return
                }
            case .inverse3:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 0.48876047
                    weightCurvePoint.normalizedTanMagnitudeIn = 0.36
                    return
                }
                if weightCurvePointCount == 3 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 0.91167784
                    weightCurvePoint.normalizedTanMagnitudeIn = 0.36
                    return
                }
            case .inverse2:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 0.69779015
                    weightCurvePoint.normalizedTanMagnitudeIn = 0.4
                    return
                }
                if weightCurvePointCount == 3 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 1.0656775
                    weightCurvePoint.normalizedTanMagnitudeIn = 0.4
                    return
                }
            case .inverse1:
                if weightCurvePointCount == 2 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 0.94985527
                    weightCurvePoint.normalizedTanMagnitudeIn = 0.44
                    return
                }
                if weightCurvePointCount == 3 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 1.2319971
                    weightCurvePoint.normalizedTanMagnitudeIn = 0.44
                    return
                }
            }
            
            weightCurvePoint.normalizedTanDirection = rotation
            weightCurvePoint.normalizedTanMagnitudeIn = inDist * tanFactorWeightCurveAuto * 3.0
            
        }
    }
    
    private func _pickleRotationDefaultMiddle(index: Int,
                                              rotation: Float,
                                              inDist: Float,
                                              outDist: Float,
                                              tanFactorWeightCurveAuto: Float) {
        
        if index >= 0 && index < weightCurvePointCount {
            let weightCurvePoint = weightCurvePoints[index]
            
            switch resetType {
            case .inverse3:
                if index == 1 && weightCurvePointCount == 3 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 1.1950371
                    weightCurvePoint.normalizedTanMagnitudeIn = 0.36
                    weightCurvePoint.normalizedTanMagnitudeOut = 0.36
                    return
                }
            case .inverse2:
                if index == 1 && weightCurvePointCount == 3 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 1.268957
                    weightCurvePoint.normalizedTanMagnitudeIn = 0.4
                    weightCurvePoint.normalizedTanMagnitudeOut = 0.4
                    return
                }
            case .inverse1:
                if index == 1 && weightCurvePointCount == 3 {
                    // [DONE] Do Not Modify!!!
                    weightCurvePoint.normalizedTanDirection = 1.3675168
                    weightCurvePoint.normalizedTanMagnitudeIn = 0.44
                    weightCurvePoint.normalizedTanMagnitudeOut = 0.44
                    return
                }
            default:
                break
            }
            weightCurvePoint.normalizedTanDirection = rotation
            weightCurvePoint.normalizedTanMagnitudeIn = inDist * tanFactorWeightCurveAuto
            weightCurvePoint.normalizedTanMagnitudeOut = outDist * tanFactorWeightCurveAuto
        }
    }
    
    private func _interpolateHeights() {
        
        // Now we need to mudge the previous and current point.
        for _ in 0..<6 {
            for weightCurvePointIndex in 0..<weightCurvePointCount {
                let weightCurvePoint = weightCurvePoints[weightCurvePointIndex]
                if weightCurvePoint.isManualHeightEnabled == false {
                    if weightCurvePointIndex > 0 {
                        if weightCurvePointIndex < (weightCurvePointCount - 1) {
                            let weightCurvePointLeft = weightCurvePoints[weightCurvePointIndex - 1]
                            let weightCurvePointRight = weightCurvePoints[weightCurvePointIndex + 1]
                            let driftFactorLeft = (weightCurvePointLeft.normalizedHeightFactor - weightCurvePointLeft.tempY)
                            let driftFactorRight = (weightCurvePointRight.normalizedHeightFactor - weightCurvePointRight.tempY)
                            var tempY = weightCurvePoint.tempY
                            tempY += driftFactorLeft * 0.5 * 0.25
                            tempY += driftFactorRight * 0.5 * 0.25
                            if tempY < 0.0 { tempY = 0.0 }
                            if tempY > 1.0 { tempY = 1.0 }
                            weightCurvePoint.holdY = tempY
                        } else {
                            weightCurvePoint.holdY = weightCurvePoint.tempY
                        }
                    } else {
                        weightCurvePoint.holdY = weightCurvePoint.tempY
                    }
                }
            }
            let weightCurvePointCount1 = (weightCurvePointCount - 1)
            for weightCurvePointIndex in 0..<weightCurvePointCount1 {
                let weightCurvePoint = weightCurvePoints[weightCurvePointIndex]
                if weightCurvePoint.isManualHeightEnabled == false {
                    weightCurvePoint.normalizedHeightFactor = weightCurvePoint.holdY
                }
            }
        }
    }
    
    private func _boneOutTempY_Standard(factor: Float) {
        for weightCurvePointIndex in 0..<weightCurvePointCount {
            let weightCurvePoint = weightCurvePoints[weightCurvePointIndex]
            weightCurvePoint.tempY = _standardMap(index: weightCurvePointIndex, count: weightCurvePointCount) * factor
            weightCurvePoint.defaultY = weightCurvePoint.tempY
            if weightCurvePoint.isManualHeightEnabled == false {
                weightCurvePoint.normalizedHeightFactor = weightCurvePoint.defaultY
            }
        }
    }
    
    private func _boneOutTempY_Linear(factor: Float) {
        for weightCurvePointIndex in 0..<weightCurvePointCount {
            let weightCurvePoint = weightCurvePoints[weightCurvePointIndex]
            weightCurvePoint.tempY = _linearMap(index: weightCurvePointIndex, count: weightCurvePointCount) * factor
            weightCurvePoint.defaultY = weightCurvePoint.tempY
            if weightCurvePoint.isManualHeightEnabled == false {
                weightCurvePoint.normalizedHeightFactor = weightCurvePoint.defaultY
            }
        }
    }
    
    private func _boneOutTempY_Inverse(factor: Float) {
        for weightCurvePointIndex in 0..<weightCurvePointCount {
            let weightCurvePoint = weightCurvePoints[weightCurvePointIndex]
            weightCurvePoint.tempY = _inverseMap(index: weightCurvePointIndex, count: weightCurvePointCount) * factor
            weightCurvePoint.defaultY = weightCurvePoint.tempY
            if weightCurvePoint.isManualHeightEnabled == false {
                weightCurvePoint.normalizedHeightFactor = weightCurvePoint.defaultY
            }
        }
    }
    
    private func _percentLinear(index: Int,
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
    
    private func _percentSkewed(index: Int,
                                count: Int) -> Float {
        var percentSkewed = _percentLinear(index: index,
                                           count: count)
        percentSkewed += (1.0 - percentSkewed) * (0.228) * percentSkewed
        return percentSkewed
    }
    
    public func _linearMap(index: Int,
                                count: Int) -> Float {
        let percentA = _percentLinear(index: index, count: count)
        let percentB = _standardMap(index: index, count: count)
        var amountRemaining = (1.0 - percentA)
        amountRemaining = (1.0 - amountRemaining)
        amountRemaining = amountRemaining * 0.5 + (amountRemaining * amountRemaining) * 0.5
        amountRemaining = (1.0 - amountRemaining)
        let shiftFactor = Float(0.32)
        var result = percentA + (percentB * amountRemaining * shiftFactor)
        if result < 0.0 { result = 0.0 }
        if result > 1.0 { result = 1.0 }
        return result
    }
    
    //π/3
    public func _inverseMap(index: Int,
                             count: Int) -> Float {
        var percentY = _percentLinear(index: index,
                                      count: count)
        let range = Math.pi_2
        let mininum = Math._pi_4
        percentY = tanf(mininum + percentY * range)
        let lowestValue = tanf(mininum)
        let highestValue = tanf(mininum + range)
        percentY = (percentY - lowestValue) / (highestValue - lowestValue)
        if percentY < 0.0 { percentY = 0.0 }
        if percentY > 1.0 { percentY = 1.0 }
        return percentY
    }
    
    public func _standardMap(index: Int,
                              count: Int) -> Float {
        var percentY = _percentSkewed(index: index,
                                      count: count)
        percentY = sinf(percentY * Math.pi_2)
        if percentY < 0.0 { percentY = 0.0 }
        if percentY > 1.0 { percentY = 1.0 }
        return percentY
    }
    
    public func refreshSpline(tanFactorWeightCurve: Float) {
        
        for weightCurvePointIndex in 0..<weightCurvePointCount {
            let weightCurvePoint = weightCurvePoints[weightCurvePointIndex]
            weightCurvePoint.tempY = (1.0 - weightCurvePoint.normalizedHeightFactor)
            weightCurvePoint.tempX = weightCurvePoint.getPosition(index: weightCurvePointIndex,
                                                                                count: weightCurvePointCount)
        }
        
        spline.removeAll(keepingCapacity: true)
        
        for weightCurvePointIndex in 0..<weightCurvePointCount {
            let weightCurvePoint = weightCurvePoints[weightCurvePointIndex]
            
            spline.addControlPoint(weightCurvePoint.tempX,
                                   weightCurvePoint.tempY)
            
            let magnitudeIn = weightCurvePoint.normalizedTanMagnitudeIn / tanFactorWeightCurve
            let magnitudeOut = weightCurvePoint.normalizedTanMagnitudeOut / tanFactorWeightCurve
            
            let dirX = sinf(weightCurvePoint.normalizedTanDirection)
            let dirY = -cosf(weightCurvePoint.normalizedTanDirection)
            
            spline.enableManualControlTanIn(at: weightCurvePointIndex,
                                            inTanX: -dirX * magnitudeIn,
                                            inTanY: -dirY * magnitudeIn)
            spline.enableManualControlTanOut(at: weightCurvePointIndex,
                                             outTanX: dirX * magnitudeOut,
                                             outTanY: dirY * magnitudeOut)
        }
        spline.solve(closed: false)
        mapper.build(spline: spline)
    }
    
    public var weightCurvePoints = [WeightCurvePoint]()
    public var weightCurvePointCount = 0
    
    public func addWeightCurvePoint(_ weightCurvePoint: WeightCurvePoint) {
        while weightCurvePoints.count <= weightCurvePointCount {
            weightCurvePoints.append(weightCurvePoint)
        }
        weightCurvePoints[weightCurvePointCount] = weightCurvePoint
        weightCurvePointCount += 1
    }
    
    public func resetWeightCurvePoints() {
        weightCurvePointCount = 0
    }
    
}
