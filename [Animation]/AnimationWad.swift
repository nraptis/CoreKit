//
//  AnimationWad.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/10/25.
//

import Foundation

public class AnimationWad {
    
    public init() {
        
    }
    
    public func updateGrabAttribute(attributeType: GrabAttributeType,
                                    value: Float) {
        switch attributeType {
        case .grabDragPower:
            grabDragPower = value
        case .grabSpeed:
            grabSpeed = value
        case .grabStiffness:
            grabStiffness = value
        case .grabGyroPower:
            grabGyroPower = value
        }
    }
    
    public func updateContinuousAttribute(attributeType: ContinuousAttributeType,
                                          value: Float,
                                          isSelected: Bool,
                                          mirrorEnabled: Bool,
                                          mirrorElementType: MirrorElementType) -> Bool {
        
        var value = value
        if (mirrorEnabled == true) && (isSelected == false) {
            switch mirrorElementType {
            case .none:
                break
            case .negative:
                value = -value
            }
        }
        
        switch attributeType {
        case .continuousDuration:
            continuousDuration = value
            return true
        case .continuousPower:
            continuousPower = value
            return true
        case .continuousAngle:
            continuousAngle = value
            return true
        case .continuousSwoop:
            continuousSwoop = value
            return true
        case .continuousStartRotation:
            continuousStartRotation = value
            return true
        case .continuousEndRotation:
            continuousEndRotation = value
            return true
        case .continuousStartScale:
            continuousStartScale = value
            return true
        case .continuousEndScale:
            continuousEndScale = value
            return true
        case .continuousWiggle:
            continuousWiggle = value
            return true
        case .continuousFrameOffset:
            continuousFrameOffset = value
            return true
        case .continuousGroup1:
            return false
        case .continuousGroup2:
            return false
        case .continuousGroup3:
            return false
        case .continuousGroup4:
            return false
        case .continuousGroup5:
            return false
        case .continuousAll:
            return false
        }
    }
    
    public func updateLoopAttribute(attributeType: LoopAttributeType,
                                    value: Float,
                                    timeLineSwatch: Swatch) -> Bool {
        switch attributeType {
        case .timeLineDuration:
            timeLine.animationDuration = value
            return true
        case .timeLineFrameOffset:
            switch timeLineSwatch {
            case .x:
                timeLine.swatchPositionX.frameOffset = value
                return true
            case .y:
                timeLine.swatchPositionY.frameOffset = value
                return true
            case .scale:
                timeLine.swatchScale.frameOffset = value
                return true
            case .rotation:
                timeLine.swatchRotation.frameOffset = value
                return true
            }
        case .timeLineSwatchX:
            return false
        case .timeLineSwatchY:
            return false
        case .timeLineSwatchScale:
            return false
        case .timeLineSwatchRotation:
            return false
        case .timeLine:
            return false
        }
    }
    
    public static let minMeasuredSize = Float(200.0)
    public static let midMeasuredSize = Float(700.0)
    public static let maxMeasuredSize = Float(1200.0)
    
    public static let measuredSizeRatio = (maxMeasuredSize / minMeasuredSize)
    public static let measuredSizeRatioInverse = (minMeasuredSize / maxMeasuredSize)

    public static let animationCursorFalloffRotation_U1 = Math.pi_3
    public static let animationCursorFalloffRotation_U2 = Math.pi_3 + Math.pi_4
    public static let animationCursorFalloffRotation_U3 = Math.pi_3 + Math.pi_2
    
    public static let animationCursorFalloffRotation_D1 = -(animationCursorFalloffRotation_U1)
    public static let animationCursorFalloffRotation_D2 = -(animationCursorFalloffRotation_U2)
    public static let animationCursorFalloffRotation_D3 = -(animationCursorFalloffRotation_U3)
    
    public static let animationCursorFalloffScale_U1 = Float(1.25)
    public static let animationCursorFalloffScale_U2 = Float(1.86)
    public static let animationCursorFalloffScale_U3 = Float(2.75)
    
    public static let animationCursorFalloffScale_D1 = Float(0.75)
    public static let animationCursorFalloffScale_D2 = Float(0.40)
    public static let animationCursorFalloffScale_D3 = Float(-0.75)
    
    public static let animationCursorScaleWeightUnit_Min = Device.isPad ? Float(132.0) : Float(172.0)
    public static let animationCursorScaleWeightUnit_Max = Device.isPad ? Float(318.0) : Float(440.0)
    
    public static let animationCursorFalloffDistance_R1_Min = Device.isPad ? Float(94.0) : Float(130.0)
    public static let animationCursorFalloffDistance_R1_Max = Device.isPad ? Float(228.0) : Float(292.0)
    public static let animationCursorFalloffDistance_R2_Min = Device.isPad ? Float(184.0) : Float(240.0)
    public static let animationCursorFalloffDistance_R2_Max = Device.isPad ? Float(410.0) : Float(572.0)
    public static let animationCursorFalloffDistance_R3_Min = Device.isPad ? Float(268.0) : Float(344.0)
    public static let animationCursorFalloffDistance_R3_Max = Device.isPad ? Float(578.0) : Float(842.0)
    
    public static let animationDragPowerMin_R1 = Float(0.32)
    public static let animationDragPowerMax_R1 = Float(1.0)
    public static let animationDragPowerMin_R2 = Float(0.36)
    public static let animationDragPowerMax_R2 = Float(1.0)
    public static let animationDragPowerMin_R3 = Float(0.72)
    public static let animationDragPowerMax_R3 = Float(1.0)
    
    static let grabDragScaleFactorMin = Float(0.1)
    static let grabDragScaleFactorMax = Float(1.0)
    
    static let grabDragRotateFactorMin = Float(0.1)
    static let grabDragRotateFactorMax = Float(1.0)
    
    public var timeLine = TimeLine()
    
    public let animationInstructionGrab = AnimationInstructionGrab()
    public let animationInstructionContinuous = AnimationInstructionContinuous()
    public let animationInstructionLoops = AnimationInstructionLoops()
    
    public var animationCursorX = Float(0.0)
    public var animationCursorY = Float(0.0)
    public var animationCursorScale = Float(1.0)
    public var animationCursorRotation = Float(0.0)
    
    public var measuredSize = AnimationWad.midMeasuredSize
    
    public var grabDragPower = AnimationConstants_Grab.power.user_default
    public var grabSpeed = AnimationConstants_Grab.speed.user_default
    public var grabStiffness = AnimationConstants_Grab.stiffness.user_default
    public var grabGyroPower = AnimationConstants_Grab.gyro.user_default
    
    var captureTouchCountGrabBefore = 0
    var captureTouchCountGrabAfter = 0
    public var isCaptureActiveGrab = false
    
    var captureTouchCountContinuousBefore = 0
    var captureTouchCountContinuousAfter = 0
    public var isCaptureActiveContinuous = false
    
    public var _snapShotContinuousDuration = Float(0.0)
    public var _snapShotContinuousAngle = Float(0.0)
    public var _snapShotContinuousPower = Float(0.0)
    public var _snapShotContinuousSwoop = Float(0.0)
    public var _snapShotContinuousWiggle = Float(0.0)
    
    public var _snapShotContinuousFrameOffset = Float(0.0)
    public var _snapShotContinuousStartScale = Float(0.0)
    public var _snapShotContinuousEndScale = Float(0.0)
    public var _snapShotContinuousStartRotation = Float(0.0)
    public var _snapShotContinuousEndRotation = Float(0.0)
    
    public var continuousDuration = AnimationConstants_Continuous.duration.user_default
    public var continuousAngle = AnimationConstants_Continuous.angle.user_default
    public var continuousPower = AnimationConstants_Continuous.power.user_default
    public var continuousSwoop = AnimationConstants_Continuous.swoop.user_default
    public var continuousWiggle = AnimationConstants_Continuous.wiggle.user_default
    
    public var continuousFrameOffset = AnimationConstants_Continuous.frameOffset.user_default
    public var continuousStartScale = AnimationConstants_Continuous.startScale.user_default
    public var continuousEndScale = AnimationConstants_Continuous.endScale.user_default
    public var continuousStartRotation = AnimationConstants_Continuous.startRotation.user_default
    public var continuousEndRotation = AnimationConstants_Continuous.endRotation.user_default
    
    public func readContinuous_Update(otherAnimationWad: AnimationWad, isMirrorMode: Bool) {
        
        animationInstructionContinuous.readContinuous(otherInstruction: otherAnimationWad.animationInstructionContinuous,
                                                      otherAnimationWad: otherAnimationWad,
                                                      animationWad: self,
                                                      isMirrorMode: isMirrorMode)
        
    }
    
    public func readContinuous_GrabStop(otherAnimationWad: AnimationWad, isMirrorMode: Bool) {
        
        continuousDuration = otherAnimationWad.continuousDuration
        if isMirrorMode {
            continuousAngle = -(otherAnimationWad.continuousAngle)
        } else {
            continuousAngle = otherAnimationWad.continuousAngle
        }
        continuousPower = otherAnimationWad.continuousPower
        if isMirrorMode {
            continuousSwoop = -(otherAnimationWad.continuousSwoop)
        } else {
            continuousSwoop = otherAnimationWad.continuousSwoop
        }
        continuousFrameOffset = otherAnimationWad.continuousFrameOffset
        continuousStartScale = otherAnimationWad.continuousStartScale
        continuousEndScale = otherAnimationWad.continuousEndScale
        if isMirrorMode {
            continuousStartRotation = -(otherAnimationWad.continuousStartRotation)
        } else {
            continuousStartRotation = otherAnimationWad.continuousStartRotation
        }
        if isMirrorMode {
            continuousEndRotation = -(otherAnimationWad.continuousEndRotation)
        } else {
            continuousEndRotation = otherAnimationWad.continuousEndRotation
        }

        animationInstructionContinuous.readContinuous(otherInstruction: otherAnimationWad.animationInstructionContinuous,
                                                      otherAnimationWad: otherAnimationWad,
                                                      animationWad: self,
                                                      isMirrorMode: isMirrorMode)
        
    }
    
    public func snapShotContinuousDragHistory() {
        _snapShotContinuousDuration = continuousDuration
        _snapShotContinuousAngle = continuousAngle
        _snapShotContinuousPower = continuousPower
        _snapShotContinuousSwoop = continuousSwoop
        _snapShotContinuousWiggle = continuousWiggle
        _snapShotContinuousFrameOffset = continuousFrameOffset
        _snapShotContinuousStartScale = continuousStartScale
        _snapShotContinuousEndScale = continuousEndScale
        _snapShotContinuousStartRotation = continuousStartRotation
        _snapShotContinuousEndRotation = continuousEndRotation
    }
    
    static func getAnimationCursorFalloffDistance_R1(format: AnimationTouchFormat,
                                                     measuredSize: Float,
                                                     userGrabDragPower: Float) -> Float {
        
        let measurePercentLinear = getMeasurePercentLinear(measuredSize: measuredSize)
        
        let animationCursorFalloffDistance_R1 = getAnimationCursorFalloffDistance_R1(measurePercentLinear: measurePercentLinear)
        
        switch format {
        case .grab:
            let grabDragPowerPercentLinear = AnimationWad.getGrabDragPowerPercentLinear(userGrabDragPower: userGrabDragPower)
            let grabDragPower_R1 = getGrabDragPower_R1(grabDragPowerPercentLinear: grabDragPowerPercentLinear)
            let adjustedFallOffDistance_R1 = animationCursorFalloffDistance_R1 * grabDragPower_R1
            return adjustedFallOffDistance_R1
            
        case .continuous:
            return animationCursorFalloffDistance_R1
        }
    }
    
    static func getAnimationCursorFalloffDistance_Radii(measuredSize: Float,
                                                        userGrabDragPower: Float,
                                                        distance_R1: inout Float,
                                                        distance_R2: inout Float) {
        
        let measurePercentLinear = getMeasurePercentLinear(measuredSize: measuredSize)
        
        let animationCursorFalloffDistance_R1 = getAnimationCursorFalloffDistance_R1(measurePercentLinear: measurePercentLinear)
        let animationCursorFalloffDistance_R2 = getAnimationCursorFalloffDistance_R2(measurePercentLinear: measurePercentLinear)
        
        let grabDragPowerPercentLinear = AnimationWad.getGrabDragPowerPercentLinear(userGrabDragPower: userGrabDragPower)
        
        let grabDragPower_R1 = getGrabDragPower_R1(grabDragPowerPercentLinear: grabDragPowerPercentLinear)
        let grabDragPower_R2 = getGrabDragPower_R2(grabDragPowerPercentLinear: grabDragPowerPercentLinear)
        
        let deltaR2R1 = animationCursorFalloffDistance_R2 - animationCursorFalloffDistance_R1
        
        let adjustedFallOffDistance_R1 = animationCursorFalloffDistance_R1 * grabDragPower_R1
        let adjustedFallOffDistance_R2 = adjustedFallOffDistance_R1 + deltaR2R1 * grabDragPower_R2
        
        distance_R1 = adjustedFallOffDistance_R1
        distance_R2 = adjustedFallOffDistance_R2
    }
    
    static func getAnimationCursorFalloffDistance_Radii(measuredSize: Float,
                                                        userGrabDragPower: Float,
                                                        distance_R1: inout Float,
                                                        distance_R2: inout Float,
                                                        distance_R3: inout Float) {
        
        let measurePercentLinear = getMeasurePercentLinear(measuredSize: measuredSize)
        
        let animationCursorFalloffDistance_R1 = getAnimationCursorFalloffDistance_R1(measurePercentLinear: measurePercentLinear)
        let animationCursorFalloffDistance_R2 = getAnimationCursorFalloffDistance_R2(measurePercentLinear: measurePercentLinear)
        let animationCursorFalloffDistance_R3 = getAnimationCursorFalloffDistance_R3(measurePercentLinear: measurePercentLinear)
        
        let grabDragPowerPercentLinear = AnimationWad.getGrabDragPowerPercentLinear(userGrabDragPower: userGrabDragPower)
        
        let grabDragPower_R1 = getGrabDragPower_R1(grabDragPowerPercentLinear: grabDragPowerPercentLinear)
        let grabDragPower_R2 = getGrabDragPower_R2(grabDragPowerPercentLinear: grabDragPowerPercentLinear)
        let grabDragPower_R3 = getGrabDragPower_R3(grabDragPowerPercentLinear: grabDragPowerPercentLinear)
        
        let deltaR2R1 = animationCursorFalloffDistance_R2 - animationCursorFalloffDistance_R1
        let deltaR3R2 = animationCursorFalloffDistance_R3 - animationCursorFalloffDistance_R2
        
        let adjustedFallOffDistance_R1 = animationCursorFalloffDistance_R1 * grabDragPower_R1
        let adjustedFallOffDistance_R2 = adjustedFallOffDistance_R1 + deltaR2R1 * grabDragPower_R2
        let adjustedFallOffDistance_R3 = adjustedFallOffDistance_R2 + deltaR3R2 * grabDragPower_R3
        
        distance_R1 = adjustedFallOffDistance_R1
        distance_R2 = adjustedFallOffDistance_R2
        distance_R3 = adjustedFallOffDistance_R3
    }
    
    static func getGrabDragSpeedPercentLinear(userGrabDragSpeed: Float) -> Float {
        AnimationConstants_Grab.speed.getPercent(userValue: userGrabDragSpeed)
        /*
        let numer = (userGrabDragSpeed - AnimationWad.userAnimationGrabSpeedMin)
        let denom = (AnimationWad.userAnimationGrabSpeedMax - AnimationWad.userAnimationGrabSpeedMin)
        var percentLinear = numer / denom
        if percentLinear > 1.0 { percentLinear = 1.0 }
        if percentLinear < 0.0 { percentLinear = 0.0 }
        return percentLinear
        */
    }
    
    static func getGrabDragStiffnessPercentLinear(userGrabDragStiffness: Float) -> Float {
        AnimationConstants_Grab.stiffness.getPercent(userValue: userGrabDragStiffness)
        /*
        let numer = (userGrabDragStiffness - AnimationWad.userAnimationGrabStiffnessMin)
        let denom = (AnimationWad.userAnimationGrabStiffnessMax - AnimationWad.userAnimationGrabStiffnessMin)
        var percentLinear = numer / denom
        if percentLinear > 1.0 { percentLinear = 1.0 }
        if percentLinear < 0.0 { percentLinear = 0.0 }
        return percentLinear
        */
    }
    
    static func getGrabDragGyroPowerPercentLinear(userGrabDragGyroPower: Float) -> Float {
        AnimationConstants_Grab.gyro.getPercent(userValue: userGrabDragGyroPower)
        /*
        let numer = (userGrabDragGyroPower - AnimationWad.userAnimationGyroPowerMin)
        let denom = (AnimationWad.userAnimationGyroPowerMax - AnimationWad.userAnimationGyroPowerMin)
        var percentLinear = numer / denom
        if percentLinear > 1.0 { percentLinear = 1.0 }
        if percentLinear < 0.0 { percentLinear = 0.0 }
        return percentLinear
        */
    }
    
    static func getGrabDragPowerPercentLinear(userGrabDragPower: Float) -> Float {
        AnimationConstants_Grab.power.getPercent(userValue: userGrabDragPower)
        /*
        let numer = (userGrabDragPower - AnimationWad.userAnimationDragPowerMin)
        let denom = (AnimationWad.userAnimationDragPowerMax - AnimationWad.userAnimationDragPowerMin)
        var percentLinear = numer / denom
        if percentLinear > 1.0 { percentLinear = 1.0 }
        if percentLinear < 0.0 { percentLinear = 0.0 }
        return percentLinear
        */
    }
    
    static func getGrabDragPower_R1(grabDragPowerPercentLinear: Float) -> Float {
        let powerLow = AnimationWad.animationDragPowerMin_R1
        let powerDelta = (AnimationWad.animationDragPowerMax_R1 - powerLow)
        return powerLow + powerDelta * grabDragPowerPercentLinear
    }
    
    static func getGrabDragPower_R2(grabDragPowerPercentLinear: Float) -> Float {
        let powerLow = AnimationWad.animationDragPowerMin_R2
        let powerDelta = (AnimationWad.animationDragPowerMax_R2 - powerLow)
        return powerLow + powerDelta * grabDragPowerPercentLinear
    }
    
    static func getGrabDragPower_R3(grabDragPowerPercentLinear: Float) -> Float {
        let powerLow = AnimationWad.animationDragPowerMin_R3
        let powerDelta = (AnimationWad.animationDragPowerMax_R3 - powerLow)
        return powerLow + powerDelta * grabDragPowerPercentLinear
    }
    
    public static func getMeasurePercentLinear(measuredSize: Float) -> Float {
        var percentLinear = (measuredSize - AnimationWad.minMeasuredSize) / (AnimationWad.maxMeasuredSize - AnimationWad.minMeasuredSize)
        if percentLinear > 1.0 { percentLinear = 1.0 }
        if percentLinear < 0.0 { percentLinear = 0.0 }
        return percentLinear
    }
    
    static func getAnimationCursorFalloffDistance_R1(measuredSize: Float) -> Float {
        let measurePercentLinear = getMeasurePercentLinear(measuredSize: measuredSize)
        return getAnimationCursorFalloffDistance_R1(measurePercentLinear: measurePercentLinear)
    }
    
    static func getAnimationCursorFalloffDistance_R1(measurePercentLinear: Float) -> Float {
        let radiusLow = AnimationWad.animationCursorFalloffDistance_R1_Min
        let radiusDelta = (AnimationWad.animationCursorFalloffDistance_R1_Max - radiusLow)
        return radiusLow + radiusDelta * measurePercentLinear
    }
    
    static func getAnimationCursorFalloffDistance_R2(measuredSize: Float) -> Float {
        let measurePercentLinear = getMeasurePercentLinear(measuredSize: measuredSize)
        return getAnimationCursorFalloffDistance_R2(measurePercentLinear: measurePercentLinear)
    }
    
    static func getAnimationCursorFalloffDistance_R2(measurePercentLinear: Float) -> Float {
        let radiusLow = AnimationWad.animationCursorFalloffDistance_R2_Min
        let radiusDelta = (AnimationWad.animationCursorFalloffDistance_R2_Max - radiusLow)
        return radiusLow + radiusDelta * measurePercentLinear
    }
    
    static func getAnimationCursorFalloffDistance_R3(measuredSize: Float) -> Float {
        let measurePercentLinear = getMeasurePercentLinear(measuredSize: measuredSize)
        return getAnimationCursorFalloffDistance_R3(measurePercentLinear: measurePercentLinear)
    }
    
    static func getAnimationCursorFalloffDistance_R3(measurePercentLinear: Float) -> Float {
        let radiusLow = AnimationWad.animationCursorFalloffDistance_R3_Min
        let radiusDelta = (AnimationWad.animationCursorFalloffDistance_R3_Max - radiusLow)
        return radiusLow + radiusDelta * measurePercentLinear
    }
    
    static func getAnimationCursorScaleWeightUnit(measuredSize: Float) -> Float {
        let measurePercentLinear = getMeasurePercentLinear(measuredSize: measuredSize)
        return getAnimationCursorScaleWeightUnit(measurePercentLinear: measurePercentLinear)
    }
    
    static func getAnimationCursorScaleWeightUnit(measurePercentLinear: Float) -> Float {
        let unitLow = AnimationWad.animationCursorScaleWeightUnit_Min
        let unitDelta = (AnimationWad.animationCursorScaleWeightUnit_Max - unitLow)
        return unitLow + unitDelta * measurePercentLinear
    }
    
    static func getGrabDragScaleFactor(grabDragPowerPercentLinear: Float) -> Float {
        let factorLow = AnimationWad.grabDragScaleFactorMin
        let factorDelta = (AnimationWad.grabDragScaleFactorMax - factorLow)
        return factorLow + factorDelta * grabDragPowerPercentLinear
    }
    
    static func getGrabDragRotateFactor(grabDragPowerPercentLinear: Float) -> Float {
        let factorLow = AnimationWad.grabDragRotateFactorMin
        let factorDelta = (AnimationWad.grabDragRotateFactorMax - factorLow)
        return factorLow + factorDelta * grabDragPowerPercentLinear
    }
    
}
