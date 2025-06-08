//
//  HistoryStateLoopAttributeAll.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/3/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public class HistoryStateLoopAttributeAll: HistoryState {
    
    public let jiggleIndex: Int
    public let startAttributes: [LoopAttribute]
    public let endAttributes: [LoopAttribute]
    public let selectedTimeLineSwatch: Swatch
    public init(jiggleIndex: Int,
                startAttributes: [LoopAttribute],
                endAttributes: [LoopAttribute],
                selectedTimeLineSwatch: Swatch,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.startAttributes = startAttributes
        self.endAttributes = endAttributes
        self.selectedTimeLineSwatch = selectedTimeLineSwatch
        super.init(historyStateType: .loopAttributeAll,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let loopAttributeType: LoopAttributeType
        if startAttributes.count > 0 {
            loopAttributeType = startAttributes[0].loopAttributeType
        } else {
            loopAttributeType = LoopAttributeType.timeLineDuration
        }
        let pageType = loopAttributeType.getPageType()
        let topMenuType = loopAttributeType.getTopMenuType()
        let timeLineType = loopAttributeType.getTimeLineType()
        let result = HistoryWorldConfiguration(documentMode: .view,
                                               editModeType: .dontCare,
                                               weightModeType: .dontCare,
                                               graphType: .dontCare,
                                               guidesType: .dontCare,
                                               jigglePointTanType: .dontCare, // TODO TODO TODO TODO
                                               guidePointTanType: .dontCare, // TODO TODO TODO TODO
                                               phoneExpandedTopType: topMenuType,
                                               
                                               timeLineType: timeLineType,
                                               animationLoopType: .forceEnter,
                                               animationContinuousType: .forceLeave,
                                               animationLoopsPageType: pageType,
                                               animationTimeLinePageType: .dontCare,
                                               animationContinuousPageType: .dontCare,
                                               timeLineSwatchType: .exact(selectedTimeLineSwatch))
        return result
    }
    
}
