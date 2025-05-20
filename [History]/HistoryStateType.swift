//
//  HistoryStateType.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

@frozen public enum HistoryStateType: UInt8 {
    
    case unknown
    
    case generateTopography
    
    case rotateOrFlipJiggle
    case rotateOrFlipGuide
    
    case createJiggle
    case deleteJiggle
    case transformJiggle
    case moveControlPoint
    case editJigglePointTanHandle
    case createJigglePoint
    case insertJigglePoint
    case deleteJigglePoint
    
    case updateJigglePointOne
    case updateJigglePointAll
    
    case updateGuidePointOne
    case updateGuidePointAll
    
    case createGuide
    case deleteGuide
    case transformGuide
    
    case moveGuidePoint
    case editGuidePointTanHandle
    case createGuidePoint
    case insertGuidePoint
    case deleteGuidePoint
    
    case moveWeightCenter
    case moveJiggleCenter
    
    case moveWeightGraphPosition
    case moveWeightGraphTangent
    
    case resetWeightGraph
    
    case loopAttributeOne
    case loopAttributesAll
    
    case continuousAttributeOne
    case continuousAttributesAll
    
    case grabAttributeOne
    case grabAttributesAll
    
}
