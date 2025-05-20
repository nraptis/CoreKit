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
    case continuousStartScale(Float)
    case continuousEndScale(Float)
    case continuousStartRotation(Float)
    case continuousEndRotation(Float)
    case continuousRotationGroup(ContinuousAttributeDataUserRotationGroup)
    case continuousScaleGroup(ContinuousAttributeDataUserScaleGroup)
    case continuousDurationGroup(ContinuousAttributeDataUserDurationGroup)
}
