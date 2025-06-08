//
//  HistoryStateReplaceJigglePointAll.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 5/20/25.
//

import Foundation

public class HistoryStateReplaceJigglePointAll: HistoryState {
    
    public let jiggleIndex: Int
    public let startDatas: [ControlPointData]
    public let startSelectedIndex: Int
    public let endDatas: [ControlPointData]
    public let endSelectedIndex: Int
    public init(jiggleIndex: Int,
                startDatas: [ControlPointData],
                startSelectedIndex: Int,
                endDatas: [ControlPointData],
                endSelectedIndex: Int,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.startDatas = startDatas
        self.startSelectedIndex = startSelectedIndex
        self.endDatas = endDatas
        self.endSelectedIndex = endSelectedIndex
        super.init(historyStateType: .replaceJigglePointAll,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .forceEnter(.points), // Good
                                               weightModeType: .dontCare, // Good
                                               graphType: .dontCare, // Good
                                               guidesType: .forceLeave, // Good
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
