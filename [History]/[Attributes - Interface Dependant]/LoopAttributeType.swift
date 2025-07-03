//
//  LoopAttributeType.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

@frozen public enum LoopAttributeType: UInt8 {
    
    case timeLineDuration
    case timeLineFrameOffset
    
    case timeLineSwatchX
    case timeLineSwatchY
    case timeLineSwatchScale
    case timeLineSwatchRotation
    
    /*
    case timeLineSwatchXPosition
    case timeLineSwatchYPosition
    case timeLineSwatchScalePosition
    case timeLineSwatchRotationPosition
    
    
    case timeLineSwatchXTanHandles
    case timeLineSwatchYPosition
    case timeLineSwatchScalePosition
    case timeLineSwatchRotationPosition
    */
    
    
    
    case timeLine
}

