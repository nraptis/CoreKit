//
//  HistoryStateReplaceGuidePointAll.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 5/20/25.
//

import Foundation

public class HistoryStateReplaceGuidePointAll: HistoryState {
    
    public let jiggleIndex: Int
    public let guideIndex: Int
    public let startDatas: [ControlPointData]
    public let startSelectedIndex: Int
    public let endDatas: [ControlPointData]
    public let endSelectedIndex: Int
    public init(jiggleIndex: Int,
                guideIndex: Int,
                startDatas: [ControlPointData],
                startSelectedIndex: Int,
                endDatas: [ControlPointData],
                endSelectedIndex: Int,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.guideIndex = guideIndex
        self.startDatas = startDatas
        self.startSelectedIndex = startSelectedIndex
        self.endDatas = endDatas
        self.endSelectedIndex = endSelectedIndex
        super.init(historyStateType: .replaceGuidePointAll,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .forceEnter(.points), // Good
                                               graphType: .forceLeave, // Good
                                               guidesType: .forceEnter, // Good
                                               jigglePointTanType: .dontCare, // TODO TODO TODO TODO
                                               guidePointTanType: .dontCare, // TODO TODO TODO TODO
                                               phoneExpandedTopType: .dontCare, // Good
                                                // Good
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
