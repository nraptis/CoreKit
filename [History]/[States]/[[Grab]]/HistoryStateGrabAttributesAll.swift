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
        let topMenuType = grabAttributeType.getTopMenuType()
        let result = HistoryWorldConfiguration(documentMode: .view,
                                               editModeType: .dontCare,
                                               weightModeType: .dontCare,
                                               graphType: .dontCare,
                                               guidesType: .forceEnter,
                                               jigglePointTanType: .dontCare, // TODO TODO TODO TODO
                                               guidePointTanType: .dontCare, // TODO TODO TODO TODO
                                               phoneExpandedTopType: topMenuType,
                                               
                                               timeLineType: .dontCare,
                                               animationLoopType: .forceLeave,
                                               animationContinuousType: .forceLeave,
                                               animationLoopsPageType: .dontCare,
                                               animationTimeLinePageType: .dontCare,
                                               animationContinuousPageType: .dontCare,
                                               timeLineSwatchType: .dontCare)
        return result
    }
    
}
