//
//  AnimationTouchPointerBag+Position.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/11/24.
//

import Foundation

extension AnimationTouchPointerBag {
    
    func captureStart_Position(animationWad: AnimationWad,
                               cursorX: Float,
                               cursorY: Float,
                               averageX: Float,
                               averageY: Float) {
        
        captureStartAverageTouchPointerPosition.x = averageX
        captureStartAverageTouchPointerPosition.y = averageY
        
        // We get the radii adjusted by the "grab drag power" (user slider)
        // Between R2 and R3, we taper off. The input value gets clamped at R3.
        var baseDistance_R1 = Float(0.0)
        var baseDistance_R2 = Float(0.0)
        var baseDistance_R3 = Float(0.0)
        AnimationWad.getAnimationCursorFalloffDistance_Radii(measuredSize: animationWad.measuredSize,
                                                       userGrabDragPower: animationWad.grabDragPower,
                                                       distance_R1: &baseDistance_R1,
                                                       distance_R2: &baseDistance_R2,
                                                       distance_R3: &baseDistance_R3)
        
        // The magnitide of the cursor as a vector...
        let cursorLengthSquared = cursorX * cursorX + cursorY * cursorY
        let cursorLength: Float
        if cursorLengthSquared > Math.epsilon {
            
            // If the cursor is not right on the average point...
            // We make this distinction just to not take sqrt(0)...
            
            // sqrt(dx^2 + dy^2) = distance
            cursorLength = sqrtf(cursorLengthSquared)
            
            
            if cursorLength <= baseDistance_R1 {
                captureStartCursorFalloffDistance_R1 = baseDistance_R1
                captureStartCursorFalloffDistance_R2 = baseDistance_R2
                captureStartCursorFalloffDistance_R3 = baseDistance_R3
            } else if cursorLength <= baseDistance_R2 {
                
                captureStartCursorFalloffDistance_R1 = cursorLength
                captureStartCursorFalloffDistance_R2 = baseDistance_R2
                captureStartCursorFalloffDistance_R3 = baseDistance_R3
            } else {
                
                captureStartCursorFalloffDistance_R1 = cursorLength
                captureStartCursorFalloffDistance_R2 = cursorLength
                captureStartCursorFalloffDistance_R3 = cursorLength
            }
            
            // Record the starting position (cursorX, cursorY)
            
            captureStartJiggleAnimationCursorPosition.x = cursorX
            captureStartJiggleAnimationCursorPosition.y = cursorY
        } else {
            
            captureStartJiggleAnimationCursorPosition.x = 0.0
            captureStartJiggleAnimationCursorPosition.y = 0.0
            captureStartCursorFalloffDistance_R1 = baseDistance_R1
            captureStartCursorFalloffDistance_R2 = baseDistance_R2
            captureStartCursorFalloffDistance_R3 = baseDistance_R3
        }
    }
    
    @MainActor func captureTrack_Position(animationWad: AnimationWad,
                                          jiggleDocument: AnimationControllerJiggleDocument,
                                          averageX: Float,
                                          averageY: Float) {
        
        // How far have we moved away from where we were
        // when we started the capture? This is our delta...
        let diffX = averageX - captureStartAverageTouchPointerPosition.x
        let diffY = averageY - captureStartAverageTouchPointerPosition.y
        
        // We "propose" the new position to be
        // start_position + delta_position
        let proposedX = captureStartJiggleAnimationCursorPosition.x + diffX
        let proposedY = captureStartJiggleAnimationCursorPosition.y + diffY
        var cursorDirX = proposedX
        var cursorDirY = proposedY
        
        // Let's figure out the magnitide of
        // the vector defined by our proposed location.
        let cursorLengthSquared = cursorDirX * cursorDirX + cursorDirY * cursorDirY
        if cursorLengthSquared > Math.epsilon {
            
            // sqrt(dx^2 + dy^2) = distance
            let cursorLength = sqrtf(cursorLengthSquared)
            
            // This is the start of our dampen radius, adjusted
            // by the user-defined slider value (grab drag power)...
            let baseDistance_R1 = AnimationWad.getAnimationCursorFalloffDistance_R1(format: format,
                                                                              measuredSize: animationWad.measuredSize,
                                                                              userGrabDragPower: animationWad.grabDragPower)
            
            if (captureStartCursorFalloffDistance_R1 > baseDistance_R1) && (cursorLength < captureStartCursorFalloffDistance_R1) {
                animationWad.animationCursorX = proposedX
                animationWad.animationCursorY = proposedY
                captureStart_Position(animationWad: animationWad,
                                      cursorX: proposedX,
                                      cursorY: proposedY,
                                      averageX: averageX,
                                      averageY: averageY)
            } else if cursorLength > captureStartCursorFalloffDistance_R1 {
                
                cursorDirX /= cursorLength
                cursorDirY /= cursorLength
                let fixedDistance = Math.fallOffOvershoot(input: cursorLength,
                                                          falloffStart: captureStartCursorFalloffDistance_R1,
                                                          resultMax: captureStartCursorFalloffDistance_R2,
                                                          inputMax: captureStartCursorFalloffDistance_R3)
                animationWad.animationCursorX = cursorDirX * fixedDistance
                animationWad.animationCursorY = cursorDirY * fixedDistance
            } else {
                
                // We're lower than R1, so we do not need any
                // dampening or tapering. Just use the recorded position.
                
                animationWad.animationCursorX = cursorDirX
                animationWad.animationCursorY = cursorDirY
            }
        } else {
            
            // In this case, we are proposing
            // that the position is (0, 0).
            // Hard to argue against that...
            
            animationWad.animationCursorX = 0.0
            animationWad.animationCursorY = 0.0
        }
        
        // In continuous mode, this will route back
        // and change the value of the sliders...
        switch format {
        case .grab:
            break
        case .continuous:
            registerContinuousStartPosition(animationWad: animationWad,
                                            jiggleDocument: jiggleDocument)
        }
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    @MainActor func registerContinuousStartPosition(animationWad: AnimationWad,
                                                    jiggleDocument: AnimationControllerJiggleDocument) {
        
        // We're converting the distance into
        // the "power" of our continuous slider...
        let cursorDirX = animationWad.animationCursorX
        let cursorDirY = animationWad.animationCursorY
        let cursorLengthSquared = cursorDirX * cursorDirX + cursorDirY * cursorDirY
        let cursorLength: Float
        if cursorLengthSquared > Math.epsilon {
            cursorLength = sqrtf(cursorLengthSquared)
        } else {
            cursorLength = 0.0
        }
        
        // Adjusted by the size of the Jiggle...
        let measurePercentLinear = AnimationWad.getMeasurePercentLinear(measuredSize: animationWad.measuredSize)
        
        // R2 is considered max-power (100%)
        let distanceR2 = AnimationWad.getAnimationCursorFalloffDistance_R2(measurePercentLinear: measurePercentLinear)
        
        // We also get the angle for the
        // "direction" continuous slider...
        let angle: Float
        if cursorLength > Math.epsilon {
            angle = -atan2f(-animationWad.animationCursorX, -animationWad.animationCursorY)
        } else {
            angle = 0.0
        }
        
        // We convert angle to the range [0.0...1.0]
        let fixedAngle = AnimationTouchPointerBag.fixRotation_GreaterThanZero(rotation: angle)
        var anglePercent = fixedAngle / Math.pi2
        if anglePercent < 0.0 { anglePercent = 0.0 }
        if anglePercent > 1.0 { anglePercent = 1.0 }
        
        // We convert power to the range [0.0...1.0]
        var powerPercent = cursorLength / distanceR2
        if powerPercent < 0.0 { powerPercent = 0.0 }
        if powerPercent > 1.0 { powerPercent = 1.0 }
        
        // We convert angle to slider value [-90.0...90.0]
        animationWad.continuousAngle = AnimationConstants_Continuous.angle.getUserValueFromPercent(anglePercent)
        
        
        // We convert power to slider value [0.0...100.0]
        //let powerMin = AnimationInstructionContinuous.userContinuousPowerMin
        //let powerMax = AnimationInstructionContinuous.userContinuousPowerMax
        animationWad.continuousPower = AnimationConstants_Continuous.power.getUserValueFromPercent(powerPercent)
        //powerMin + (powerMax - powerMin) * powerPercent
        
        
        // This will trigger the sliders to update, that is all.
        // It's also the reason we're on the main actor...
        jiggleDocument.animationContinuousDraggingPublisher.send(())
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    static func fixRotation_GreaterThanZero(rotation: Float) -> Float {
        var result = rotation
        if result >= Math.pi2 || result <= Math._pi2 {
            result = fmodf(rotation, Math.pi2)
        }
        if result < 0.0 {
            result += Math.pi2
        }
        return result
    }
    
}
