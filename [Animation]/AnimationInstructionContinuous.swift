//
//  AnimationInstructionContinuous.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/7/24.
//

import Foundation

public class AnimationInstructionContinuous: AnimationCommandsCommandable {
    
    public static let userContinuousAngleMin = Float(-180.0)
    public static let userContinuousAngleMax = Float(180.0)
    public static let userContinuousAngleDefault = Float(0.0)
    
    public static let userContinuousDurationMin = Float(0.0)
    public static let userContinuousDurationMax = Float(100.0)
    public static let userContinuousDurationDefault = Float(62.0)
    
    public static let userContinuousPowerMin = Float(0.0)
    public static let userContinuousPowerMax = Float(100.0)
    public static let userContinuousPowerDefault = Float(25.0)
    
    public static let userContinuousSwoopMin = Float(-100.0)
    public static let userContinuousSwoopMax = Float(100.0)
    public static let userContinuousSwoopDefault = Float(0.0)
    
    public static let userContinuousFrameOffsetMin = Float(0.0)
    public static let userContinuousFrameOffsetMax = Float(100.0)
    public static let userContinuousFrameOffsetDefault = Float(0.0)
    
    public static let userContinuousScaleMin = Float(-100.0)
    public static let userContinuousScaleMax = Float(100.0)
    public static let userContinuousStartScaleDefault = Float(0.0)
    public static let userContinuousEndScaleDefault = Float(0.0)
    
    public static let userContinuousRotationMin = Float(-180.0)
    public static let userContinuousRotationMax = Float(180.0)
    public static let userContinuousStartRotationDefault = Float(0.0)
    public static let userContinuousEndRotationDefault = Float(0.0)
    
    public static let continuousDurationMin = Float(0.20)
    public static let continuousDurationMax = Float(1.86)
    
    public var continuousFrame = Float(0.0)
    
    let pointerBag = AnimationTouchPointerBag(format: .continuous)
    let stateBag = AnimationTouchStateBag(format: .continuous)
    
    public init() {
        
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    func update_Inactive(deltaTime: Float) {
        pointerBag.update(deltaTime: deltaTime)
        continuousFrame = 0.0
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    func update_Active(deltaTime: Float,
                       animationWad: AnimationWad,
                       jiggleDocument: AnimationControllerJiggleDocument,
                       isGyroEnabled: Bool,
                       clock: Float) {
        
        pointerBag.update(deltaTime: deltaTime)
        
        if !animationWad.isCaptureActiveContinuous {
            
            let continuousDuration = getContinuousDuration(animationWad: animationWad)
            if continuousDuration > Math.epsilon {
                
                continuousFrame += deltaTime
                if continuousFrame >= continuousDuration {
                    continuousFrame -= continuousDuration
                }
                
                // ==============================
                // ==============================
                // Chapter I - The position:
                // ==============================
                // ==============================
                
                var percentLinearBase = continuousFrame / continuousDuration
                if percentLinearBase > 1.0 { percentLinearBase = 1.0 }
                if percentLinearBase < 0.0 { percentLinearBase = 0.0 }
                
                var continuousAngle = (animationWad.continuousAngle - Self.userContinuousAngleMin) / (Self.userContinuousAngleMax - Self.userContinuousAngleMin)
                if continuousAngle < 0.0 { continuousAngle = 0.0 }
                if continuousAngle > 1.0 { continuousAngle = 1.0 }
                continuousAngle *= Math.pi2
                
                let dirX = sinf(continuousAngle)
                let dirY = -cosf(continuousAngle)
                
                let swoopDirX = sinf(continuousAngle + Math.pi_2)
                let swoopDirY = -cosf(continuousAngle + Math.pi_2)
                
                let continuousPower = (animationWad.continuousPower - Self.userContinuousPowerMin) / (Self.userContinuousPowerMax - Self.userContinuousPowerMin)
                let continuousSwoop = (animationWad.continuousSwoop - Self.userContinuousSwoopMin) / (Self.userContinuousSwoopMax - Self.userContinuousSwoopMin)
                
                let measurePercentLinear = AnimationWad.getMeasurePercentLinear(measuredSize: animationWad.measuredSize)
                let distanceR2 = AnimationWad.getAnimationCursorFalloffDistance_R2(measurePercentLinear: measurePercentLinear)
                
                let startX = dirX * distanceR2 * continuousPower
                let startY = dirY * distanceR2 * continuousPower
                
                let endX = -startX
                let endY = -startY
                
                let diffX = (endX - startX)
                let diffY = (endY - startY)
                
                let distanceSquared = diffX * diffX + diffY * diffY
                let distance: Float
                if distanceSquared > Math.epsilon {
                    distance = sqrtf(distanceSquared)
                } else {
                    distance = 0.0
                }
                
                let continuousFrameOffsetPercent = getContinuousFrameOffsetPercent(animationWad: animationWad)
                var movementDirection = percentLinearBase * Math.pi2 + continuousFrameOffsetPercent * Math.pi2
                movementDirection -= Math.pi_2
                if movementDirection > Math.pi2 {
                    movementDirection -= Math.pi2
                }
                if movementDirection < 0.0 {
                    movementDirection += Math.pi2
                }
                
                var movementPercent = sinf(movementDirection)
                movementPercent = (1.0 + movementPercent) * 0.5
                if movementPercent > 1.0 { movementPercent = 1.0 }
                if movementPercent < 0.0 { movementPercent = 0.0 }
                
                let centerX = startX + (endX - startX) * movementPercent
                let centerY = startY + (endY - startY) * movementPercent
                
                let swoopPercent = sinf(movementDirection + Math.pi_2)
                let swoopArmLength = (distance * 0.5) * (-1.0 + continuousSwoop * 2.0)
                animationWad.animationCursorX = centerX + swoopDirX * swoopArmLength * swoopPercent
                animationWad.animationCursorY = centerY + swoopDirY * swoopArmLength * swoopPercent
                
                
                // ==============================
                // ==============================
                // Chapter II - The scale:
                // ==============================
                // ==============================
                
                let continuousStartScale = (animationWad.continuousStartScale - Self.userContinuousScaleMin) / (Self.userContinuousScaleMax - Self.userContinuousScaleMin)
                let continuousEndScale = (animationWad.continuousEndScale - Self.userContinuousScaleMin) / (Self.userContinuousScaleMax - Self.userContinuousScaleMin)
                
                let startScale: Float
                if continuousStartScale > 0.5 {
                    var scalePercent = (continuousStartScale - 0.5) * 2.0
                    if scalePercent > 1.0 { scalePercent = 1.0 }
                    if scalePercent < 0.0 { scalePercent = 0.0 }
                    startScale = 1.0 + (AnimationWad.animationCursorFalloffScale_U2 - 1.0) * scalePercent
                } else if continuousStartScale < 0.5 {
                    var scalePercent = 1.0 - (continuousStartScale) * 2.0
                    if scalePercent > 1.0 { scalePercent = 1.0 }
                    if scalePercent < 0.0 { scalePercent = 0.0 }
                    startScale = 1.0 - (1.0 - AnimationWad.animationCursorFalloffScale_D2) * scalePercent
                } else {
                    startScale = 1.0
                }
                
                let endScale: Float
                if continuousEndScale > 0.5 {
                    var scalePercent = (continuousEndScale - 0.5) * 2.0
                    if scalePercent > 1.0 { scalePercent = 1.0 }
                    if scalePercent < 0.0 { scalePercent = 0.0 }
                    endScale = 1.0 + (AnimationWad.animationCursorFalloffScale_U2 - 1.0) * scalePercent
                } else if continuousEndScale < 0.5 {
                    var scalePercent = 1.0 - (continuousEndScale) * 2.0
                    if scalePercent > 1.0 { scalePercent = 1.0 }
                    if scalePercent < 0.0 { scalePercent = 0.0 }
                    endScale = 1.0 - (1.0 - AnimationWad.animationCursorFalloffScale_D2) * scalePercent
                } else {
                    endScale = 1.0
                }
                
                animationWad.animationCursorScale = startScale + (endScale - startScale) * movementPercent
                animationWad.animationInstructionGrab.registerCursorScale(animationWad: animationWad, scale: animationWad.animationCursorScale)
                
                
                // ==============================
                // ==============================
                // Chapter III - The rotation:
                // ==============================
                // ==============================
                
                let continuousStartRotation = (animationWad.continuousStartRotation - Self.userContinuousRotationMin) / (Self.userContinuousRotationMax - Self.userContinuousRotationMin)
                let continuousEndRotation = (animationWad.continuousEndRotation - Self.userContinuousRotationMin) / (Self.userContinuousRotationMax - Self.userContinuousRotationMin)
                
                let rotationU2 = AnimationWad.animationCursorFalloffRotation_U2
                let rotationD2 = AnimationWad.animationCursorFalloffRotation_D2
                
                let startRotation: Float = rotationD2 + (rotationU2 - rotationD2) * continuousStartRotation
                let endRotation: Float = rotationD2 + (rotationU2 - rotationD2) * continuousEndRotation
                
                animationWad.animationCursorRotation = startRotation + (endRotation - startRotation) * movementPercent
                animationWad.animationInstructionGrab.registerCursorRotation(animationWad: animationWad, rotation: animationWad.animationCursorRotation)
            }
        }
    }
    
    // [Animation Mode Verify] 12-20-2024
    // Looks good, no problem. I've read each line.
    // I tested this a bit more because it's new...
    func snapToAnimationStartFrame(animationWad: AnimationWad) {
        let continuousDuration = getContinuousDuration(animationWad: animationWad)
        let continuousFrameOffsetPercent = getContinuousFrameOffsetPercent(animationWad: animationWad)
        continuousFrame = continuousDuration - (continuousDuration * continuousFrameOffsetPercent)
    }
    
    // [Animation Mode Verify] 12-20-2024
    // This seems right, it's a little obtuse.
    @MainActor func captureContinuousStartConditions(animationWad: AnimationWad,
                                                     jiggleDocument: AnimationControllerJiggleDocument) {
        pointerBag.continuousRegisterAllStartValues(animationWad: animationWad,
                                                    jiggleDocument: jiggleDocument)
        jiggleDocument.animationContinuousSyncAllPublisher.send(())
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    func getContinuousDuration(animationWad: AnimationWad) -> Float {
        // User thinks of "speed" not "duration", so higher "speed" is lower "duration..."
        let userContinuousDurationPercentLinear = (animationWad.continuousDuration - Self.userContinuousDurationMin) / (Self.userContinuousDurationMax - Self.userContinuousDurationMin)
        let continuousDurationPercentLinear = (1.0 - userContinuousDurationPercentLinear)
        let continuousDurationPercent = Math.mixPercentQuadratic(percent: continuousDurationPercentLinear, linearFactor: 0.35)
        let continuousDuration = Self.continuousDurationMin + (Self.continuousDurationMax - Self.continuousDurationMin) * continuousDurationPercent
        return continuousDuration
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    func getContinuousFrameOffsetPercent(animationWad: AnimationWad) -> Float {
        let numer = (animationWad.continuousFrameOffset - Self.userContinuousFrameOffsetMin)
        let denom = (Self.userContinuousFrameOffsetMax - Self.userContinuousFrameOffsetMin)
        var result = numer / denom
        if result < 0.0 { result = 0.0 }
        if result > 1.0 { result = 1.0 }
        return result
    }
    
}
