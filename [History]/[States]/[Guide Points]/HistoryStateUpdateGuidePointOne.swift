//
//  HistoryStateUpdateGuidePoint.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/14/25.
//

import Foundation

//attemptResetGuidePointTanCurrent
//attemptResetGuidePointTanBoth
public class HistoryStateUpdateGuidePointOne: HistoryState {
    
    public let jiggleIndex: Int
    public let guideIndex: Int
    public let guidePointIndex: Int
    public let startData: ControlPointData
    public let endData: ControlPointData
    public let multiModeSelectionType: MultiModeSelectionType
    public let tanType: TanType
    
    public init(jiggleIndex: Int,
                guideIndex: Int,
                guidePointIndex: Int,
                startData: ControlPointData,
                endData: ControlPointData,
                multiModeSelectionType: MultiModeSelectionType,
                tanType: TanType,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.guideIndex = guideIndex
        self.guidePointIndex = guidePointIndex
        self.startData = startData
        self.endData = endData
        self.multiModeSelectionType = multiModeSelectionType
        self.tanType = tanType
        super.init(historyStateType: .updateGuidePointOne,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {

        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .forceEnter(.points), // Good
                                               graphType: .forceLeave, // Good
                                               guidesType: .forceEnter, // Good
                                               jigglePointTanType: .dontCare, // Good
                                               guidePointTanType: .forceEnter, // Good
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
