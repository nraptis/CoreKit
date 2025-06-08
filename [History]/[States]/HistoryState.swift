//
//  HistoryState.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public class HistoryState {
    
    public let historyStateType: HistoryStateType
    internal let creationInterfaceConfiguration: any InterfaceConfigurationConforming
    public init(historyStateType: HistoryStateType,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.historyStateType = historyStateType
        self.creationInterfaceConfiguration = interfaceConfiguration
    }
    
    public func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        HistoryWorldConfiguration(documentMode: .edit,
                                  editModeType: .dontCare,
                                  weightModeType: .dontCare,
                                  graphType: .dontCare,
                                  guidesType: .dontCare,
                                  jigglePointTanType: .dontCare,
                                  guidePointTanType: .dontCare,
                                  phoneExpandedTopType: .dontCare,
                                  timeLineType: .dontCare,
                                  animationLoopType: .dontCare,
                                  animationContinuousType: .dontCare,
                                  animationLoopsPageType: .dontCare,
                                  animationTimeLinePageType: .dontCare,
                                  animationContinuousPageType: .dontCare,
                                  timeLineSwatchType: .dontCare)
    }
    
}
