//
//  AnimationInstructionContinuous.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/7/24.
//

import Foundation

public class AnimationInstructionContinuous: AnimationCommandsCommandable {
    
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
                
                let continuousAngle = AnimationConstants_Continuous.angle.getValue(userValue: animationWad.continuousAngle)
                let continuousWiggle = AnimationConstants_Continuous.wiggle.getValue(userValue: animationWad.continuousWiggle)
                
                let dirX = sinf(continuousAngle)
                let dirY = -cosf(continuousAngle)
                
                let swoopDirX = sinf(continuousAngle + Math.pi_2)
                let swoopDirY = -cosf(continuousAngle + Math.pi_2)
                
                let continuousPower = AnimationConstants_Continuous.power.getPercent(userValue: animationWad.continuousPower)
                let continuousSwoop = AnimationConstants_Continuous.angle.getPercent(userValue: animationWad.continuousSwoop)
                
                let measurePercentLinear = AnimationWad.getMeasurePercentLinear(measuredSize: animationWad.measuredSize)
                let distanceR2 = AnimationWad.getAnimationCursorFalloffDistance_R2(measurePercentLinear: measurePercentLinear)
                
                let startX = dirX * distanceR2 * continuousPower
                let startY = dirY * distanceR2 * continuousPower
                
                var endLength = distanceR2 * continuousPower
                if continuousWiggle > 0.0 {
                    endLength += (distanceR2 / 2.4) * continuousWiggle * continuousPower
                } else if continuousWiggle < 0.0 {
                    endLength -= (distanceR2 / 2.4) * (-continuousWiggle) * continuousPower
                }
                
                let endX = -dirX * endLength
                let endY = -dirY * endLength
                
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
                
                let continuousStartScale = AnimationConstants_Continuous.startScale.getPercent(userValue: animationWad.continuousStartScale)
                //(animationWad.continuousStartScale - Self.userContinuousScaleMin) / (Self.userContinuousScaleMax - Self.userContinuousScaleMin)
                
                let continuousEndScale = AnimationConstants_Continuous.endScale.getPercent(userValue: animationWad.continuousEndScale)
                //(animationWad.continuousEndScale - Self.userContinuousScaleMin) / (Self.userContinuousScaleMax - Self.userContinuousScaleMin)
                
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
                
                let continuousStartRotation = AnimationConstants_Continuous.startRotation.getPercent(userValue: animationWad.continuousStartRotation)
                //(animationWad.continuousStartRotation - Self.userContinuousRotationMin) / (Self.userContinuousRotationMax - Self.userContinuousRotationMin)
                let continuousEndRotation = AnimationConstants_Continuous.endRotation.getPercent(userValue: animationWad.continuousEndRotation)
                //(animationWad.continuousEndRotation - Self.userContinuousRotationMin) / (Self.userContinuousRotationMax - Self.userContinuousRotationMin)
                
                let rotationU2 = AnimationWad.animationCursorFalloffRotation_U2
                let rotationD2 = AnimationWad.animationCursorFalloffRotation_D2
                
                let startRotation: Float = rotationD2 + (rotationU2 - rotationD2) * continuousStartRotation
                let endRotation: Float = rotationD2 + (rotationU2 - rotationD2) * continuousEndRotation
                
                animationWad.animationCursorRotation = startRotation + (endRotation - startRotation) * movementPercent
                animationWad.animationInstructionGrab.registerCursorRotation(animationWad: animationWad, rotation: animationWad.animationCursorRotation)
            }
        }
    }
    
    func readContinuous(otherInstruction: AnimationInstructionContinuous,
                        otherAnimationWad: AnimationWad,
                        animationWad: AnimationWad,
                        isMirrorMode: Bool) {
        
        if isMirrorMode {
            animationWad.animationCursorRotation = -otherAnimationWad.animationCursorRotation
        } else {
            animationWad.animationCursorRotation = otherAnimationWad.animationCursorRotation
        }
        animationWad.animationInstructionGrab.registerCursorRotation(animationWad: animationWad, rotation: animationWad.animationCursorRotation)
        
        animationWad.animationCursorScale = otherAnimationWad.animationCursorScale
        animationWad.animationInstructionGrab.registerCursorScale(animationWad: animationWad, scale: animationWad.animationCursorScale)
        
        // Go to the same frame, so it will be same percents etc
        continuousFrame = otherInstruction.continuousFrame
        
        var otherDirX = otherAnimationWad.animationCursorX
        var otherDirY = otherAnimationWad.animationCursorY
        
        let otherDistanceSquared = otherDirX * otherDirX + otherDirY * otherDirY
        let otherDistance: Float
        if otherDistanceSquared > Math.epsilon {
            otherDistance = sqrtf(otherDistanceSquared)
            otherDirX /= otherDistance
            otherDirY /= otherDistance
        } else {
            otherDistance = 0.0
        }
        
        let selfMeasurePercentLinear = AnimationWad.getMeasurePercentLinear(measuredSize: animationWad.measuredSize)
        let otherMeasurePercentLinear = AnimationWad.getMeasurePercentLinear(measuredSize: otherAnimationWad.measuredSize)
        
        // R2 is considered max-power (100%)
        let selfDistanceR1 = AnimationWad.getAnimationCursorFalloffDistance_R1(measurePercentLinear: selfMeasurePercentLinear)
        let otherDistanceR1 = AnimationWad.getAnimationCursorFalloffDistance_R1(measurePercentLinear: otherMeasurePercentLinear)
        
        let selfDistanceR2 = AnimationWad.getAnimationCursorFalloffDistance_R2(measurePercentLinear: selfMeasurePercentLinear)
        let otherDistanceR2 = AnimationWad.getAnimationCursorFalloffDistance_R2(measurePercentLinear: otherMeasurePercentLinear)
        
        if otherDistance <= otherDistanceR1 {
            let percent = otherDistance / otherDistanceR1
            if isMirrorMode {
                animationWad.animationCursorX = -otherDirX * selfDistanceR1 * percent
            } else {
                animationWad.animationCursorX = otherDirX * selfDistanceR1 * percent
            }
            animationWad.animationCursorY = otherDirY * selfDistanceR1 * percent
            
        } else {
            let percentLinear = (otherDistance - otherDistanceR1) / (otherDistanceR2 - otherDistanceR1)
            if percentLinear <= 0.0 {
                if isMirrorMode {
                    animationWad.animationCursorX = -otherDirX * selfDistanceR1
                } else {
                    animationWad.animationCursorX = otherDirX * selfDistanceR1
                }
                animationWad.animationCursorY = otherDirY * selfDistanceR1
                
            } else if percentLinear >= 1.0 {
                if isMirrorMode {
                    animationWad.animationCursorX = -otherDirX * selfDistanceR2
                } else {
                    animationWad.animationCursorX = otherDirX * selfDistanceR2
                }
                animationWad.animationCursorY = otherDirY * selfDistanceR2
            } else {
                //let factor = asinf(Float(percentLinear)) / Math.pi_2
                //let factor = asinf(Float(percentLinear)) / Math.pi_2
                //let factor = sinf(Float(percentLinear * (Math.pi_2)))
                
                let factor = percentLinear
                
                
                //Math.fallOffOvershoot(input: <#T##Float#>, falloffStart: <#T##Float#>, resultMax: <#T##Float#>, inputMax: <#T##Float#>)
                
                let smartDistance = selfDistanceR1 + (selfDistanceR2 - selfDistanceR1) * factor
                if isMirrorMode {
                    animationWad.animationCursorX = -otherDirX * smartDistance
                } else {
                    animationWad.animationCursorX = otherDirX * smartDistance
                }
                animationWad.animationCursorY = otherDirY * smartDistance
            }
        }
    }
    
    // [Animation Mode Verify] 12-20-2024
    // Looks good, no problem. I've read each line.
    // I tested this a bit more because it's new...
    public func snapToAnimationStartFrame(animationWad: AnimationWad) {
        let continuousDuration = getContinuousDuration(animationWad: animationWad)
        let continuousFrameOffsetPercent = getContinuousFrameOffsetPercent(animationWad: animationWad)
        continuousFrame = continuousDuration - (continuousDuration * continuousFrameOffsetPercent)
    }
    
    // [Animation Mode Verify] 12-20-2024
    // This seems right, it's a little obtuse.
    @MainActor public func captureContinuousStartConditions(animationWad: AnimationWad,
                                                     jiggleDocument: AnimationControllerJiggleDocument) {
        pointerBag.continuousRegisterAllStartValues(animationWad: animationWad,
                                                    jiggleDocument: jiggleDocument)
        jiggleDocument.animationContinuousSyncAllPublisher.send(())
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    func getContinuousDuration(animationWad: AnimationWad) -> Float {
        // User thinks of "speed" not "duration", so higher "speed" is lower "duration..."
        let userContinuousDurationPercentLinear = AnimationConstants_Continuous.duration.getPercent(userValue: animationWad.continuousDuration)
        //(animationWad.continuousDuration - Self.userContinuousDurationMin) / (Self.userContinuousDurationMax - Self.userContinuousDurationMin)
        let continuousDurationPercentLinear = (1.0 - userContinuousDurationPercentLinear)
        let continuousDurationPercent = Math.mixPercentQuadratic(percent: continuousDurationPercentLinear, linearFactor: 0.35)
        
        let lo = AnimationConstants_Continuous.duration.value_lo
        let hi = AnimationConstants_Continuous.duration.value_hi
        let continuousDuration = lo + (hi - lo) * continuousDurationPercent
        return continuousDuration
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    func getContinuousFrameOffsetPercent(animationWad: AnimationWad) -> Float {
        AnimationConstants_Continuous.frameOffset.getPercent(userValue: animationWad.continuousFrameOffset)
        //let numer = (animationWad.continuousFrameOffset - Self.userContinuousFrameOffsetMin)
        //let denom = (Self.userContinuousFrameOffsetMax - Self.userContinuousFrameOffsetMin)
        //var result = numer / denom
        //if result < 0.0 { result = 0.0 }
        //if result > 1.0 { result = 1.0 }
        //return result
    }
    
}
