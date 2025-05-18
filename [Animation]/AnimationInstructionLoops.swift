//
//  AnimationInstructionLoops.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/7/24.
//

import Foundation

// [Animation Mode Verify] 12-20-2024
// Looks good, no problem. We are using everything
// in this protocol, it's all working to specification.
//
public class AnimationInstructionLoops {
    
    typealias Point = Math.Point
    
    public static let userLoopDurationMin = Float(0.0)
    public static let userLoopDurationMax = Float(100.0)
    public static let userLoopDurationDefault = Float(62.0)
    
    public static let userLoopFrameOffsetMin = Float(0.0)
    public static let userLoopFrameOffsetMax = Float(100.0)
    public static let userLoopFrameOffsetDefault = Float(0.0)
    public static let userLoopFrameOffsetZero = userLoopFrameOffsetMin
    public static let userLoopFrameOffsetQuarter = userLoopFrameOffsetMin + (userLoopFrameOffsetMax - userLoopFrameOffsetMin) * 0.25
    
    public static let loopDurationMin = Float(0.24)
    public static let loopDurationMax = Float(1.78)
    
    public var keyFrame = Float(0.0)
    
    public init() {
        
    }
    
    public func update_Inactive(deltaTime: Float) {
        keyFrame = 0.0
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    //
    // This depends largely on the smoother, which
    // is not in this animation package.
    //
    // All the logic has been examined, it's
    // organized by chapter, and it's tested.
    public func update_Active(deltaTime: Float,
                       animationWad: AnimationWad,
                       jiggleDocument: AnimationControllerJiggleDocument,
                       isGyroEnabled: Bool) {
        
        let userLoopDurationPercentLinear = (animationWad.timeLine.animationDuration - Self.userLoopDurationMin) / (Self.userLoopDurationMax - Self.userLoopDurationMin)
        let loopDurationPercentLinear = (1.0 - userLoopDurationPercentLinear)
        let loopDurationPercent = Math.mixPercentQuadratic(percent: loopDurationPercentLinear, linearFactor: 0.35)
        let loopDuration = Self.loopDurationMin + (Self.loopDurationMax - Self.loopDurationMin) * loopDurationPercent
        
        keyFrame += deltaTime
        while keyFrame >= loopDuration {
            keyFrame -= loopDuration
        }
        
        let frameOffsetMin = AnimationInstructionLoops.userLoopFrameOffsetMin
        let frameOffsetDelta = AnimationInstructionLoops.userLoopFrameOffsetMax - AnimationInstructionLoops.userLoopFrameOffsetMin
        
        let measurePercentLinear = AnimationWad.getMeasurePercentLinear(measuredSize: animationWad.measuredSize)
        let distanceR2 = AnimationWad.getAnimationCursorFalloffDistance_R2(measurePercentLinear: measurePercentLinear)
        
        // ==============================
        // ==============================
        // Chapter I - The x position:
        // ==============================
        // ==============================
        
        let swatchPositionX = animationWad.timeLine.swatchPositionX
        let channelPositionX = swatchPositionX.selectedChannel
        var frameOffsetX = (animationWad.timeLine.swatchPositionX.frameOffset - frameOffsetMin) / frameOffsetDelta
        if frameOffsetX > 1.0 { frameOffsetX = 1.0 }
        if frameOffsetX < 0.0 { frameOffsetX = 0.0 }
        var percentX = (keyFrame + (frameOffsetX * loopDuration)) / Float(loopDuration)
        percentX = constrainInZeroToOne(value: percentX)
        if channelPositionX.smoother.baseCount > 1 {
            let value = channelPositionX.smoother.scrape(percent: percentX) / TimeLineSmoother.SCALE
            animationWad.animationCursorX = convertFromZeroOneToPositiveOrNegativeRange(value: value, range: distanceR2)
        }
        
        
        // ==============================
        // ==============================
        // Chapter II - The y position:
        // ==============================
        // ==============================
        
        let swatchPositionY = animationWad.timeLine.swatchPositionY
        let channelPositionY = swatchPositionY.selectedChannel
        var frameOffsetY = (animationWad.timeLine.swatchPositionY.frameOffset - frameOffsetMin) / frameOffsetDelta
        if frameOffsetY > 1.0 { frameOffsetY = 1.0 }
        if frameOffsetY < 0.0 { frameOffsetY = 0.0 }
        var percentY = (keyFrame + (frameOffsetY * loopDuration)) / Float(loopDuration)
        percentY = constrainInZeroToOne(value: percentY)
        if channelPositionY.smoother.baseCount > 1 {
            let value = channelPositionY.smoother.scrape(percent: percentY) / TimeLineSmoother.SCALE
            animationWad.animationCursorY = convertFromZeroOneToPositiveOrNegativeRange(value: value, range: distanceR2)
        }
        
        
        // ==============================
        // ==============================
        // Chapter III - The scale:
        // ==============================
        // ==============================
        
        let swatchScale = animationWad.timeLine.swatchScale
        let channelScale = swatchScale.selectedChannel
        var frameOffsetScale = (animationWad.timeLine.swatchScale.frameOffset - frameOffsetMin) / frameOffsetDelta
        if frameOffsetScale > 1.0 { frameOffsetScale = 1.0 }
        if frameOffsetScale < 0.0 { frameOffsetScale = 0.0 }
        var percentScale = (keyFrame + (frameOffsetScale * loopDuration)) / Float(loopDuration)
        percentScale = constrainInZeroToOne(value: percentScale)
        let scaleD2 = AnimationWad.animationCursorFalloffScale_D2
        let scaleU2 = AnimationWad.animationCursorFalloffScale_U2
        if channelScale.smoother.baseCount > 1 {
            let value = channelScale.smoother.scrape(percent: percentScale) / TimeLineSmoother.SCALE
            animationWad.animationCursorScale = scaleD2 + (scaleU2 - scaleD2) * value
            animationWad.animationInstructionGrab.registerCursorScale(animationWad: animationWad, scale: animationWad.animationCursorScale)
        } else {
            animationWad.animationCursorScale = 1.0
            animationWad.animationInstructionGrab.registerCursorScale(animationWad: animationWad, scale: animationWad.animationCursorScale)
        }
        
        // ==============================
        // ==============================
        // Chapter IV - The rotation:
        // ==============================
        // ==============================
        
        let swatchRotation = animationWad.timeLine.swatchRotation
        let channelRotation = swatchRotation.selectedChannel
        var frameOffsetRotation = (animationWad.timeLine.swatchRotation.frameOffset - frameOffsetMin) / frameOffsetDelta
        if frameOffsetRotation > 1.0 { frameOffsetRotation = 1.0 }
        if frameOffsetRotation < 0.0 { frameOffsetRotation = 0.0 }
        var percentRotation = (keyFrame + (frameOffsetRotation * loopDuration)) / Float(loopDuration)
        percentRotation = constrainInZeroToOne(value: percentRotation)
        let rotationD2 = AnimationWad.animationCursorFalloffRotation_D2
        let rotationU2 = AnimationWad.animationCursorFalloffRotation_U2
        if channelRotation.smoother.baseCount > 1 {
            let value = channelRotation.smoother.scrape(percent: percentRotation) / TimeLineSmoother.SCALE
            animationWad.animationCursorRotation = rotationD2 + (rotationU2 - rotationD2) * value
            animationWad.animationInstructionGrab.registerCursorRotation(animationWad: animationWad, rotation: animationWad.animationCursorRotation)
            
        } else {
            animationWad.animationCursorRotation = 0.0
            animationWad.animationInstructionGrab.registerCursorRotation(animationWad: animationWad, rotation: animationWad.animationCursorRotation)
        }
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    // I've tested it in a playground with 300,000
    // different numbers, all ended up as normal.
    private func constrainInZeroToOne(value: Float) -> Float {
        
        if value < 0.0 {
            // value = -1.2
            // valuei = -1
            // fraction = 0.2
            let valuei = Float(Int(value))
            let fraction = (-value) + valuei
            let result = (1.0 - fraction)
            return result
        } else if value > 1.0 {
            // value = 1.2
            // valuei = 1
            // fraction = 0.2
            let valuei = Float(Int(value))
            let fraction = value - valuei
            let result = fraction
            return result
        } else {
            return value
        }
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    private func convertFromZeroOneToPositiveOrNegativeRange(value: Float, range: Float) -> Float {
        var result = 2.0 * value - 1.0
        if result < -1.0 { result = -1.0 }
        if result > 1.0 { result = 1.0 }
        return result * range
    }
    
}
