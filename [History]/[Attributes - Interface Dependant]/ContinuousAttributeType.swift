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
    case continuousWiggle
    case continuousStartScale
    case continuousEndScale
    case continuousStartRotation
    case continuousEndRotation
    case continuousGroup1
    case continuousGroup2
    case continuousGroup3
    case continuousGroup4
    case continuousGroup5
}

extension ContinuousAttributeType {
    
    public func getInterfacePages() -> [Int] {
        switch self {
        case .continuousAll:
            return [1, 2, 3, 4, 5]
        case .continuousFrameOffset:
            return [5]
        case .continuousDuration:
            return [1]
        case .continuousAngle:
            return [2]
        case .continuousPower:
            return [1]
        case .continuousSwoop:
            return [2]
        case .continuousWiggle:
            return [5]
        case .continuousStartScale:
            return [4]
        case .continuousEndScale:
            return [4]
        case .continuousStartRotation:
            return [3]
        case .continuousEndRotation:
            return [3]
        case .continuousGroup1:
            return [1]
        case .continuousGroup2:
            return [2]
        case .continuousGroup3:
            return [3]
        case .continuousGroup4:
            return [4]
        case .continuousGroup5:
            return [5]
        }
    }
}

extension ContinuousAttributeType {

    
}
