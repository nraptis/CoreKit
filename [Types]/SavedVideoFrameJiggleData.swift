//
//  SavedVideoFrameJiggleData.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 5/18/25.
//

import Foundation

public class SavedVideoFrameJiggleData {
    
    public let animationCursorX: Float
    public let animationCursorY: Float
    public let animationCursorScale: Float
    public let animationCursorRotation: Float
    
    public init(animationCursorX: Float,
         animationCursorY: Float,
         animationCursorScale: Float,
         animationCursorRotation: Float) {
        self.animationCursorX = animationCursorX
        self.animationCursorY = animationCursorY
        self.animationCursorScale = animationCursorScale
        self.animationCursorRotation = animationCursorRotation
    }
    
}
