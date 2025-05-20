//
//  HistoryStateContinuousAttributeOne.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/5/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public class HistoryStateContinuousAttributeOne: HistoryState {
    
    public let jiggleIndex: Int
    public let startAttribute: ContinuousAttribute
    public let endAttribute: ContinuousAttribute
    public init(jiggleIndex: Int,
         startAttribute: ContinuousAttribute,
         endAttribute: ContinuousAttribute) {
        self.jiggleIndex = jiggleIndex
        self.startAttribute = startAttribute
        self.endAttribute = endAttribute
        super.init(.continuousAttributeOne)
    }
    
    public override func getWorldConfiguration() -> HistoryWorldConfiguration {
        
        let animationContinuousType: HistoryWorldConfiguration.ThreePageType
        let expandTopType: HistoryWorldConfiguration.ExpandedType
        let continuousAttributeType: ContinuousAttributeType = startAttribute.continuousAttributeType
        switch continuousAttributeType {
        case .continuousAll:
            animationContinuousType = .dontCare
            expandTopType = .dontCare
        case .continuousFrameOffset:
            animationContinuousType = .forcePage2
            expandTopType = .dontCare
        case .continuousDuration:
            animationContinuousType = .forcePage1
            expandTopType = .forceEnter
        case .continuousAngle:
            animationContinuousType = .forcePage1
            expandTopType = .dontCare
        case .continuousPower:
            animationContinuousType = .forcePage1
            expandTopType = .forceEnter
        case .continuousSwoop:
            animationContinuousType = .forcePage3
            expandTopType = .dontCare
        case .continuousStartScale:
            animationContinuousType = .forcePage2
            expandTopType = .forceEnter
        case .continuousEndScale:
            animationContinuousType = .forcePage2
            expandTopType = .forceEnter
        case .continuousStartRotation:
            animationContinuousType = .forcePage3
            expandTopType = .forceEnter
        case .continuousEndRotation:
            animationContinuousType = .forcePage3
            expandTopType = .forceEnter
        case .continuousRotationGroup:
            animationContinuousType = .forcePage3
            expandTopType = .forceEnter
        case .continuousScaleGroup:
            animationContinuousType = .forcePage2
            expandTopType = .forceEnter
        case .continuousDurationGroup:
            animationContinuousType = .forcePage1
            expandTopType = .forceEnter
        }
        
        let result = HistoryWorldConfiguration(documentMode: .view,
                                               editModeType: .dontCare,
                                               weightModeType: .dontCare,
                                               graphType: .dontCare,
                                               guidesType: .dontCare,
                                               phoneExpandedTopType: expandTopType,
                                               phoneExpandedBottomType: .dontCare,
                                               timeLineType: .dontCare,
                                               animationLoopType: .forceLeave,
                                               animationContinuousType: .forceEnter,
                                               animationLoopsPageType: .dontCare,
                                               animationTimeLinePageType: .dontCare,
                                               animationContinuousPageType: animationContinuousType,
                                               timeLineSwatchType: .dontCare,
                                               jigglePointTanType: .dontCare,
                                               guidePointTanType: .dontCare)
        return result
    }
}

