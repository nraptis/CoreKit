//
//  ContinuousAttributeType.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

@frozen public enum ContinuousAttributeType: UInt8 {
    case continuousAll
    case continuousFrameOffset
    case continuousDuration
    case continuousAngle
    case continuousPower
    case continuousSwoop
    case continuousStartScale
    case continuousEndScale
    case continuousStartRotation
    case continuousEndRotation
    case continuousRotationGroup
    case continuousScaleGroup
    case continuousDurationGroup
}
