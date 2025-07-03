//
//  HistoryStateCreateMultipleGuides.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 6/10/25.
//

import Foundation

public class HistoryStateCreateMultipleGuides: HistoryState {
    
    public let jiggleIndex: Int
    public let guideIndex: Int
    public let datas: [Data]
    public init(jiggleIndex: Int,
                guideIndex: Int,
                datas: [Data],
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.datas = datas
        self.jiggleIndex = jiggleIndex
        self.guideIndex = guideIndex
        super.init(historyStateType: .createMultipleGuides,
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
