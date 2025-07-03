//
//  HistoryStateGrabAttributeAll.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/7/24.
//

import Foundation

public class HistoryStateGrabAttributeAll: HistoryState {
    
    public let jiggleIndex: Int
    public let startAttributes: [GrabAttribute]
    public let endAttributes: [GrabAttribute]
    public init(jiggleIndex: Int,
                startAttributes: [GrabAttribute],
                endAttributes: [GrabAttribute],
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.startAttributes = startAttributes
        self.endAttributes = endAttributes
        super.init(historyStateType: .grabAttributeAll,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let grabAttributeType: GrabAttributeType
        if startAttributes.count > 0 {
            grabAttributeType = startAttributes[0].grabAttributeType
        } else {
            grabAttributeType = .grabDragPower
        }
        let topMenuType = HistoryStateGrabAttributeOne.getTopMenuType(grabAttributeType: grabAttributeType)
        let result = HistoryWorldConfiguration(documentMode: .view, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .dontCare, // Good
                                               graphType: .dontCare, // Good
                                               guidesType: .forceEnter, // Good
                                               jigglePointTanType: .dontCare, // Good
                                               guidePointTanType: .dontCare, // Good
                                               phoneExpandedTopType: topMenuType, // Good
                                               timeLineType: .dontCare, // Good
                                               animationLoopType: .forceLeave, // Good
                                               animationContinuousType: .forceLeave, // Good
                                               animationLoopsPageType: .dontCare, // Good
                                               animationTimeLinePageType: .dontCare, // Good
                                               animationContinuousPageType: .dontCare, // Good
                                               timeLineSwatchType: .dontCare)  // Good
        return result
    }
    
}
