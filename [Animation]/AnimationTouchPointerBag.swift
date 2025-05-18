//
//  AnimationTouchPointerBag.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/8/24.
//

import Foundation

class AnimationTouchPointerBag {
    
    static let captureTrackDistanceThreshold = Float(4.0)
    static let captureTrackDistanceThresholdSquared = (captureTrackDistanceThreshold * captureTrackDistanceThreshold)
    
    typealias Point = Math.Point
    
    var touchPointerCount = 0
    var touchPointers = [AnimationTouchPointer]()
    
    var tempTouchPointerCount = 0
    var tempTouchPointers = [AnimationTouchPointer]()
    
    var isCaptureValid = false
    
    // Position Tracking
    var captureStartAverageTouchPointerPosition = Point(x: 0.0, y: 0.0)
    var captureStartJiggleAnimationCursorPosition = Point(x: 0.0, y: 0.0)
    var captureStartCursorFalloffDistance_R1 = Float(0.0)
    var captureStartCursorFalloffDistance_R2 = Float(0.0)
    var captureStartCursorFalloffDistance_R3 = Float(0.0)
    
    // Scale Tracking
    var captureStartJiggleAnimationCursorScale = Float(1.0)
    var captureStartCursorFalloffScale_U1 = Float(0.0)
    var captureStartCursorFalloffScale_U2 = Float(0.0)
    var captureStartCursorFalloffScale_U3 = Float(0.0)
    var captureStartCursorFalloffScale_D1 = Float(0.0)
    var captureStartCursorFalloffScale_D2 = Float(0.0)
    var captureStartCursorFalloffScale_D3 = Float(0.0)
    
    // Rotation Tracking
    var captureStartJiggleAnimationCursorRotation = Float(0.0)
    var captureStartCursorFalloffRotation_U1 = Float(0.0)
    var captureStartCursorFalloffRotation_U2 = Float(0.0)
    var captureStartCursorFalloffRotation_U3 = Float(0.0)
    var captureStartCursorFalloffRotation_D1 = Float(0.0)
    var captureStartCursorFalloffRotation_D2 = Float(0.0)
    var captureStartCursorFalloffRotation_D3 = Float(0.0)
    
    let format: AnimationTouchFormat
    init(format: AnimationTouchFormat) {
        self.format = format
    }
    
    func update(deltaTime: Float) {
        for pointerIndex in 0..<touchPointerCount {
            touchPointers[pointerIndex].update(deltaTime: deltaTime)
        }
        
        touchPointersRemoveExpired()
    }
    
    @MainActor func continuousRegisterAllStartValues(animationWad: AnimationWad,
                                                     jiggleDocument: AnimationControllerJiggleDocument) {
        registerContinuousStartPosition(animationWad: animationWad,
                                        jiggleDocument: jiggleDocument)
        registerContinuousStartScale(animationWad: animationWad,
                                     jiggleDocument: jiggleDocument)
        registerContinuousStartRotation(animationWad: animationWad,
                                        jiggleDocument: jiggleDocument)
    }
    
    func captureStart(animationWad: AnimationWad) {
        let avaragesResponse = calculateConsiderTouchPointersAndGetAverages()
        let averageX: Float
        let averageY: Float
        switch avaragesResponse {
        case .invalid:
            isCaptureValid = false
            return
        case .valid(let point):
            isCaptureValid = true
            averageX = point.x
            averageY = point.y
        }
        
        // ==============================
        // ==============================
        // Chapter I - The position:
        // ==============================
        // ==============================
        captureStart_Position(animationWad: animationWad,
                              cursorX: animationWad.animationCursorX,
                              cursorY: animationWad.animationCursorY,
                              averageX: averageX,
                              averageY: averageY)
        
        // ==============================
        // ==============================
        // Chapter II - The scale:
        // ==============================
        // ==============================
        captureStart_PrepareScale(averageX: averageX,
                                  averageY: averageY)
        captureStart_Scale(animationWad: animationWad,
                           scale: animationWad.animationCursorScale)
        
        // ==============================
        // ==============================
        // Chapter III - The rotation:
        // ==============================
        // ==============================
        captureStart_PrepareRotate(averageX: averageX,
                                   averageY: averageY)
        captureStart_Rotate(animationWad: animationWad,
                            rotation: animationWad.animationCursorRotation)
    }
    
    // [Animation Mode Verify] 12-19-2024
    // Looks good, no problem. I've read each line.
    @MainActor func captureTrack(animationWad: AnimationWad,
                                 jiggleDocument: AnimationControllerJiggleDocument) {
        
        if !isCaptureValid {
            return
        }
        
        let avaragesResponse = calculateConsiderTouchPointersAndGetAverages()
        let averageX: Float
        let averageY: Float
        switch avaragesResponse {
        case .invalid:
            isCaptureValid = false
            return
        case .valid(let point):
            averageX = point.x
            averageY = point.y
        }
        
        // ==============================
        // ==============================
        // Chapter I - The position:
        // ==============================
        // ==============================
        captureTrack_Position(animationWad: animationWad,
                              jiggleDocument: jiggleDocument,
                              averageX: averageX,
                              averageY: averageY)
        
        // ==============================
        // ==============================
        // Chapter II - The scale:
        // ==============================
        // ==============================
        let scaleResponse = captureTrack_PrepareScale(animationWad: animationWad,
                                                      averageX: averageX,
                                                      averageY: averageY)
        switch scaleResponse {
        case .invalid:
            break
        case .valid(let scaleData):
            captureTrack_Scale(animationWad: animationWad,
                               jiggleDocument: jiggleDocument,
                               scaleData: scaleData,
                               averageX: averageX,
                               averageY: averageY)
        }
        
        // ==============================
        // ==============================
        // Chapter III - The rotation:
        // ==============================
        // ==============================
        let rotateResponse = captureTrack_PrepareRotate(animationWad: animationWad,
                                                        averageX: averageX,
                                                        averageY: averageY)
        if rotateResponse {
            captureTrack_Rotate(animationWad: animationWad,
                                jiggleDocument: jiggleDocument,
                                averageX: averageX,
                                averageY: averageY)
        }
    }
    
}
