//
//  HistoryStateUpdateJigglePointAll.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public class HistoryStateUpdateJigglePointAll: HistoryState {
    
    public let jiggleIndex: Int
    public let controlPointIndex: Int
    public let startDatas: [ControlPointData]
    public let endDatas: [ControlPointData]
    public let multiModeSelectionType: MultiModeSelectionType
    public let tanType: TanType
    
    
    public init(jiggleIndex: Int,
                controlPointIndex: Int,
                startDatas: [ControlPointData],
                endDatas: [ControlPointData],
                multiModeSelectionType: MultiModeSelectionType,
                tanType: TanType,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.controlPointIndex = controlPointIndex
        self.startDatas = startDatas
        self.endDatas = endDatas
        self.multiModeSelectionType = multiModeSelectionType
        self.tanType = tanType
        super.init(historyStateType: .updateJigglePointAll,
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
