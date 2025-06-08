//
//  HistoryStateUpdateJigglePoint.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/14/25.
//

import Foundation

public class HistoryStateUpdateJigglePointOne: HistoryState {
    
    public let jiggleIndex: Int
    public let controlPointIndex: Int
    public let startData: ControlPointData
    public let endData: ControlPointData
    public let multiModeSelectionType: MultiModeSelectionType
    public let tanType: TanType
    
    
    public init(jiggleIndex: Int,
                controlPointIndex: Int,
                startData: ControlPointData,
                endData: ControlPointData,
                multiModeSelectionType: MultiModeSelectionType,
                tanType: TanType,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.controlPointIndex = controlPointIndex
        self.startData = startData
        self.endData = endData
        self.multiModeSelectionType = multiModeSelectionType
        self.tanType = tanType
        super.init(historyStateType: .updateJigglePointOne,
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
