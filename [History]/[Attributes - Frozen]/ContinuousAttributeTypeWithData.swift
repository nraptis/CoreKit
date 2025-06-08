//
//  ContinuousAttributeTypeWithData.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

@frozen public enum ContinuousAttributeTypeWithData {
    case continuousAll(ContinuousAttributeDataUserAll)
    case continuousFrameOffset(Float)
    case continuousDuration(Float)
    case continuousAngle(Float)
    case continuousPower(Float)
    case continuousSwoop(Float)
    case continuousWiggle(Float)
    case continuousStartScale(Float)
    case continuousEndScale(Float)
    case continuousStartRotation(Float)
    case continuousEndRotation(Float)
    case continuousGroup1(ContinuousAttributeDataUserGroup1)
    case continuousGroup2(ContinuousAttributeDataUserGroup2)
    case continuousGroup3(ContinuousAttributeDataUserGroup3)
    case continuousGroup4(ContinuousAttributeDataUserGroup4)
    case continuousGroup5(ContinuousAttributeDataUserGroup5)
}
