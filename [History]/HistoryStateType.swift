//
//  HistoryStateType.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

@frozen public enum HistoryStateType: UInt8 {
    
    case unknown

    case createJiggle
    case transformJiggle
    case rotateOrFlipJiggle
    case moveJiggleCenter
    case moveWeightCenter
    case deleteJiggle

    case createGuide
    case transformGuide
    case rotateOrFlipGuide
    case generateTopography
    case deleteGuide

    case createJigglePoint
    case insertJigglePoint
    case moveJigglePoint
    case moveJigglePointTanHandle
    case updateJigglePointOne
    case updateJigglePointAll
    case replaceJigglePointAll
    case deleteJigglePoint

    case createGuidePoint
    case insertGuidePoint
    case moveGuidePoint
    case moveGuidePointTanHandle
    case updateGuidePointOne
    case updateGuidePointAll
    case replaceGuidePointAll
    case deleteGuidePoint

    case moveWeightGraphPosition
    case moveWeightGraphTangent
    case resetWeightGraph

    case grabAttributeOne
    case grabAttributeAll

    case continuousAttributeOne
    case continuousAttributeAll

    case loopAttributeOne
    case loopAttributeAll
    
}
