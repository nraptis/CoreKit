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
    public let pageType: HistoryWorldConfiguration.FivePageType
    public init(jiggleIndex: Int,
                startAttribute: ContinuousAttribute,
                endAttribute: ContinuousAttribute,
                interfaceConfiguration: any InterfaceConfigurationConforming,
                pageType: HistoryWorldConfiguration.FivePageType) {
        self.jiggleIndex = jiggleIndex
        self.startAttribute = startAttribute
        self.endAttribute = endAttribute
        self.pageType = pageType
        super.init(historyStateType: .continuousAttributeOne,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .view, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .dontCare, // Good
                                               graphType: .dontCare, // Good
                                               guidesType: .dontCare, // Good
                                               jigglePointTanType: .dontCare, // Good
                                               guidePointTanType: .dontCare, // Good
                                               phoneExpandedTopType: .forceEnter, // Good
                                               timeLineType: .dontCare, // Good
                                               animationLoopType: .forceLeave, // Good
                                               animationContinuousType: .forceEnter, // Good
                                               animationLoopsPageType: .dontCare, // Good
                                               animationTimeLinePageType: .dontCare, // Good
                                               animationContinuousPageType: pageType, // Good
                                               timeLineSwatchType: .dontCare) // Good
        return result
    }
    
}
