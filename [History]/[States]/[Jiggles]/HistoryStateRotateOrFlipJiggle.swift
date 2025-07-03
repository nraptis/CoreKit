//
//  HistoryStateRotateOrFlipJiggle.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 9/8/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public class HistoryStateRotateOrFlipJiggle: HistoryState {
    
    public let jiggleIndex: Int
    public let startData: Data
    public let endData: Data
    public init(jiggleIndex: Int,
                startData: Data,
                endData: Data,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.startData = startData
        self.endData = endData
        super.init(historyStateType: .rotateOrFlipJiggle,
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
