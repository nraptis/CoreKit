//
//  HistoryStateCreateMultipleJiggles.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 6/10/25.
//

import Foundation

public class HistoryStateCreateMultipleJiggles: HistoryState {
    
    public let jiggleIndex: Int
    public let datas: [Data]
    public init(jiggleIndex: Int,
                datas: [Data],
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.datas = datas
        super.init(historyStateType: .createMultipleJiggles,
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

