//
//  HistoryStateGrabAttributeOne.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/7/24.
//

import Foundation

public class HistoryStateGrabAttributeOne: HistoryState {
    
    public let jiggleIndex: Int
    public let startAttribute: GrabAttribute
    public let endAttribute: GrabAttribute
    public init(jiggleIndex: Int,
                startAttribute: GrabAttribute,
                endAttribute: GrabAttribute,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.startAttribute = startAttribute
        self.endAttribute = endAttribute
        super.init(historyStateType: .grabAttributeOne,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let grabAttributeType = startAttribute.grabAttributeType
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
