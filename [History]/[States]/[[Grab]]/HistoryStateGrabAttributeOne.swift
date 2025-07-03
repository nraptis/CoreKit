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
    
    static func getTopMenuType(grabAttributeType: GrabAttributeType) -> HistoryWorldConfiguration.ExpandedType {
        let topMenuType: HistoryWorldConfiguration.ExpandedType
        switch grabAttributeType {
            
        case .all:
            topMenuType = .forceEnter
        case .grabDragPower:
            topMenuType = .forceEnter
        case .grabSpeed:
            topMenuType = .forceEnter
        case .grabStiffness:
            topMenuType = .forceEnter
        case .grabGyroPower:
            topMenuType = .forceEnter
        }
        return topMenuType
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let grabAttributeType = startAttribute.grabAttributeType
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
