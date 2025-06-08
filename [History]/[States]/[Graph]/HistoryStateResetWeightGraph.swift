//
//  HistoryStateResetWeightGraph.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/18/25.
//

import Foundation

public class HistoryStateResetWeightGraph: HistoryState {
    
    public let jiggleIndex: Int
    public let storageNodeStart: WeightGraphStorageNode
    public let storageNodeMiddle: WeightGraphStorageNode
    public let storageNodeEnd: WeightGraphStorageNode
    public let startResetType: WeightCurveResetType
    public let endResetType: WeightCurveResetType
    
    public init(jiggleIndex: Int,
                startResetType: WeightCurveResetType,
                endResetType: WeightCurveResetType,
                storageNodeStart: WeightGraphStorageNode,
                storageNodeMiddle: WeightGraphStorageNode,
                storageNodeEnd: WeightGraphStorageNode,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.startResetType = startResetType
        self.endResetType = endResetType
        self.storageNodeStart = storageNodeStart
        self.storageNodeMiddle = storageNodeMiddle
        self.storageNodeEnd = storageNodeEnd
        super.init(historyStateType: .resetWeightGraph,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .dontCare, // Good
                                               graphType: .forceEnter, // Good
                                               guidesType: .forceEnter, // Good
                                               jigglePointTanType: .dontCare, // TODO TODO TODO TODO
                                               guidePointTanType: .dontCare, // TODO TODO TODO TODO
                                               phoneExpandedTopType: .forceEnter, // Good
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
