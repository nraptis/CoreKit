//
//  HistoryStateDeleteJiggle.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public class HistoryStateDeleteJiggle: HistoryState {
    
    public let jiggleIndex: Int
    public let data: Data
    public init(jiggleIndex: Int,
                data: Data,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.data = data
        super.init(historyStateType: .deleteJiggle,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .dontCare, // Good
                                               graphType: .dontCare, // Good
                                               guidesType: .forceLeave, // Good
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
