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
    public let pageType: HistoryWorldConfiguration.ThreePageType
    public init(jiggleIndex: Int,
                startAttributes: [LoopAttribute],
                endAttributes: [LoopAttribute],
                selectedTimeLineSwatch: Swatch,
                interfaceConfiguration: any InterfaceConfigurationConforming,
                pageType: HistoryWorldConfiguration.ThreePageType) {
        self.jiggleIndex = jiggleIndex
        self.startAttributes = startAttributes
        self.endAttributes = endAttributes
        self.selectedTimeLineSwatch = selectedTimeLineSwatch
        self.pageType = pageType
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
        
        let timeLineType = HistoryStateLoopAttributeOne.getTimeLineType(loopAttributeType: loopAttributeType,
                                                                        selectedTimeLineSwatch: selectedTimeLineSwatch,
                                                                        creationInterfaceConfiguration: creationInterfaceConfiguration)
        let timeLineSwatchType = HistoryStateLoopAttributeOne.getSwatchType(loopAttributeType: loopAttributeType,
                                                                            selectedTimeLineSwatch: selectedTimeLineSwatch)
        let topMenuType = HistoryStateLoopAttributeOne.getTopMenuType(loopAttributeType: loopAttributeType)
        
        let result = HistoryWorldConfiguration(documentMode: .view, // Good
                                                editModeType: .dontCare, // Good
                                                weightModeType: .dontCare, // Good
                                                graphType: .dontCare, // Good
                                                guidesType: .dontCare, // Good
                                                jigglePointTanType: .dontCare, // Good
                                                guidePointTanType: .dontCare, // Good
                                                phoneExpandedTopType: topMenuType, // Good
                                                timeLineType: timeLineType, // Good
                                                animationLoopType: .forceEnter, // Good
                                                animationContinuousType: .forceLeave, // Good
                                                animationLoopsPageType: .dontCare, // Good
                                                animationTimeLinePageType: pageType, // Good
                                                animationContinuousPageType: .dontCare, // Good
                                                timeLineSwatchType: timeLineSwatchType) // Good
         return result
    }
    
}
