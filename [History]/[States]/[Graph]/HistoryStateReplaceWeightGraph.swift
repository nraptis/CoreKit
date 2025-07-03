//
//  HistoryStateReplaceWeightGraph.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 6/11/25.
//

import Foundation

public class HistoryStateReplaceWeightGraph: HistoryState {
    
    public let jiggleIndex: Int
    public let startStorageNodeStart: WeightGraphStorageNode
    public let startStorageNodeMiddle: WeightGraphStorageNode
    public let startStorageNodeEnd: WeightGraphStorageNode
    public let startResetType: WeightCurveResetType
    
    public let endStorageNodeStart: WeightGraphStorageNode
    public let endStorageNodeMiddle: WeightGraphStorageNode
    public let endStorageNodeEnd: WeightGraphStorageNode
    public let endResetType: WeightCurveResetType
    
    public init(jiggleIndex: Int,
                startStorageNodeStart: WeightGraphStorageNode,
                startStorageNodeMiddle: WeightGraphStorageNode,
                startStorageNodeEnd: WeightGraphStorageNode,
                startResetType: WeightCurveResetType,
                endStorageNodeStart: WeightGraphStorageNode,
                endStorageNodeMiddle: WeightGraphStorageNode,
                endStorageNodeEnd: WeightGraphStorageNode,
                endResetType: WeightCurveResetType,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        
        self.jiggleIndex = jiggleIndex
        self.startResetType = startResetType
        
        self.startStorageNodeStart = startStorageNodeStart
        self.startStorageNodeMiddle = startStorageNodeMiddle
        self.startStorageNodeEnd = startStorageNodeEnd
        
        self.endStorageNodeStart = endStorageNodeStart
        self.endStorageNodeMiddle = endStorageNodeMiddle
        self.endStorageNodeEnd = endStorageNodeEnd
        
        self.endResetType = endResetType
        
        super.init(historyStateType: .replaceWeightGraph,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .dontCare, // Good
                                               graphType: .forceEnter, // Good
                                               guidesType: .forceEnter, // Good
                                               jigglePointTanType: .dontCare, // Good
                                               guidePointTanType: .dontCare, // Good
                                               phoneExpandedTopType: .forceEnter, // Good
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
