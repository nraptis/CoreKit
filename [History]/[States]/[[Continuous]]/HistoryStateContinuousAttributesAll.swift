//
//  HistoryStateContinuousAttributeAll.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/5/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public class HistoryStateContinuousAttributeAll: HistoryState {
    
    public let jiggleIndex: Int
    public let startAttributes: [ContinuousAttribute]
    public let endAttributes: [ContinuousAttribute]
    public init(jiggleIndex: Int,
                startAttributes: [ContinuousAttribute],
                endAttributes: [ContinuousAttribute],
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.startAttributes = startAttributes
        self.endAttributes = endAttributes
        super.init(historyStateType: .continuousAttributeAll,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        
        let pageType = ContinuousWorldConfigurationResolver.getFivePageType(creationInterfaceConfiguration: creationInterfaceConfiguration,
                                                                        currentInterfaceConfiguration: currentInterfaceConfiguration,
                                                                        startAttributes: startAttributes,
                                                                        endAttributes: endAttributes,
                                                                        isUndo: isUndo)
        
        let topMenuExpandedType: HistoryWorldConfiguration.ExpandedType
        if currentInterfaceConfiguration.isExpandedTop == false {
            topMenuExpandedType = .forceEnter
        } else {
            topMenuExpandedType = .dontCare
        }
        
        let result = HistoryWorldConfiguration(documentMode: .view,
                                               editModeType: .dontCare,
                                               weightModeType: .dontCare,
                                               graphType: .dontCare,
                                               guidesType: .dontCare,
                                               jigglePointTanType: .dontCare, // TODO TODO TODO TODO
                                               guidePointTanType: .dontCare, // TODO TODO TODO TODO
                                               phoneExpandedTopType: topMenuExpandedType,
                                               
                                               timeLineType: .dontCare,
                                               animationLoopType: .forceLeave,
                                               animationContinuousType: .forceEnter,
                                               animationLoopsPageType: .dontCare,
                                               animationTimeLinePageType: .dontCare,
                                               animationContinuousPageType: pageType,
                                               timeLineSwatchType: .dontCare)
        return result
    }
    
}
