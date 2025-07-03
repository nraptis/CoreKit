//
//  HistoryStateContinuousAttributeAll.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/5/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public class HistoryStateContinuousAttributeAll: HistoryState {
    
    public let jiggleIndex: Int
    public let startAttributes: [ContinuousAttribute]
    public let endAttributes: [ContinuousAttribute]
    public let pageType: HistoryWorldConfiguration.FivePageType
    public init(jiggleIndex: Int,
                startAttributes: [ContinuousAttribute],
                endAttributes: [ContinuousAttribute],
                interfaceConfiguration: any InterfaceConfigurationConforming,
                pageType: HistoryWorldConfiguration.FivePageType) {
        self.jiggleIndex = jiggleIndex
        self.startAttributes = startAttributes
        self.endAttributes = endAttributes
        self.pageType = pageType
        super.init(historyStateType: .continuousAttributeAll,
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
