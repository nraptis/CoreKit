//
//  HistoryStateDeleteJigglePoint.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public class HistoryStateDeleteJigglePoint: HistoryState {
    public let jiggleIndex: Int
    public let controlPointIndex: Int
    public let data: ControlPointData
    public init(jiggleIndex: Int,
                controlPointIndex: Int,
                data: ControlPointData,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.controlPointIndex = controlPointIndex
        self.data = data
        super.init(historyStateType: .deleteJigglePoint,
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
