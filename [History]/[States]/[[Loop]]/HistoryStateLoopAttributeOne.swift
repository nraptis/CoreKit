//
//  HistoryStateLoopAttributeSingle.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/3/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public class HistoryStateLoopAttributeOne: HistoryState {
    
    public let jiggleIndex: Int
    public let startAttribute: LoopAttribute
    public let endAttribute: LoopAttribute
    public let selectedTimeLineSwatch: Swatch
    public init(jiggleIndex: Int,
                    startAttribute: LoopAttribute,
                    endAttribute: LoopAttribute,
                    selectedTimeLineSwatch: Swatch,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.startAttribute = startAttribute
        self.endAttribute = endAttribute
        self.selectedTimeLineSwatch = selectedTimeLineSwatch
        super.init(historyStateType: .loopAttributeOne,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let loopAttributeType = startAttribute.loopAttributeType
        let pageType = loopAttributeType.getPageType()
        let topMenuType = loopAttributeType.getTopMenuType()
        let timeLineType = loopAttributeType.getTimeLineType()
        let result = HistoryWorldConfiguration(documentMode: .view,
                                               editModeType: .dontCare,
                                               weightModeType: .dontCare,
                                               graphType: .dontCare,
                                               guidesType: .dontCare,
                                               jigglePointTanType: .dontCare,
                                               guidePointTanType: .dontCare,
                                               phoneExpandedTopType: topMenuType,
                                               timeLineType: timeLineType,
                                               animationLoopType: .forceEnter,
                                               animationContinuousType: .forceLeave,
                                               animationLoopsPageType: .dontCare,
                                               animationTimeLinePageType: pageType,
                                               animationContinuousPageType: .dontCare,
                                               timeLineSwatchType: .exact(selectedTimeLineSwatch))
        return result
    }
    
}
