//
//  HistoryStateDeleteGuide.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public class HistoryStateDeleteGuide: HistoryState {
    
    public let jiggleIndex: Int
    public let guideIndex: Int
    public let data: Data
    public init(jiggleIndex: Int,
                guideIndex: Int,
                data: Data,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.guideIndex = guideIndex
        self.data = data
        super.init(historyStateType: .deleteGuide,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .forceEnter(.guides), // Good
                                               graphType: .forceLeave, // Good
                                               guidesType: .forceEnter, // Good
                                               jigglePointTanType: .dontCare, // Good
                                               guidePointTanType: .dontCare, // Good
                                               phoneExpandedTopType: .dontCare, // Good
                                               timeLineType: .dontCare, // Good
                                               animationLoopType: .dontCare, // Good
                                               animationContinuousType: .dontCare, // Good
                                               animationLoopsPageType: .dontCare, // Good
                                               animationTimeLinePageType: .dontCare, // Good
                                               animationContinuousPageType: .dontCare, // Good
                                               timeLineSwatchType: .dontCare) // Good
        return result
    }
    
}
