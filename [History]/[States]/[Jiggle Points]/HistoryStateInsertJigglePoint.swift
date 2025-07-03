//
//  HistoryStateInsertJigglePoint.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/19/25.
//

import Foundation

public class HistoryStateInsertJigglePoint: HistoryState {
    
    public let jiggleIndex: Int
    public let controlPointIndex: Int
    public let selectedJigglePointIndex: Int
    public let point: Math.Point
    public init(jiggleIndex: Int,
                controlPointIndex: Int,
                selectedJigglePointIndex: Int,
                point: Math.Point,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.selectedJigglePointIndex = selectedJigglePointIndex
        self.controlPointIndex = controlPointIndex
        self.point = point
        super.init(historyStateType: .insertJigglePoint,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .forceEnter(.points), // Good
                                               weightModeType: .dontCare, // Good
                                               graphType: .dontCare, // Good
                                               guidesType: .forceLeave, // Good
                                               jigglePointTanType: .forceLeave, // Good
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
