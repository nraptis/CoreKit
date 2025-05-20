//
//  HistoryStateResetWeightGraph.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/18/25.
//

import Foundation

public class HistoryStateResetWeightGraph: HistoryState {
    
    public struct StorageNode {
        public let startHeightManual: Bool
        public let startHeightFactor: Float
        public let startTangentManual: Bool
        public let startDirection: Float
        public let startMagnitudeIn: Float
        public let startMagnitudeOut: Float
        public init(startHeightManual: Bool,
                    startHeightFactor: Float,
                    startTangentManual: Bool,
                    startDirection: Float,
                    startMagnitudeIn: Float,
                    startMagnitudeOut: Float) {
            self.startHeightManual = startHeightManual
            self.startHeightFactor = startHeightFactor
            self.startTangentManual = startTangentManual
            self.startDirection = startDirection
            self.startMagnitudeIn = startMagnitudeIn
            self.startMagnitudeOut = startMagnitudeOut
        }
    }
    
    public let jiggleIndex: Int
    public let storageNodes: [StorageNode]
    public init(jiggleIndex: Int,
         storageNodes: [StorageNode]) {
        self.jiggleIndex = jiggleIndex
        self.storageNodes = storageNodes
        super.init(.resetWeightGraph)
    }
    
    public override func getWorldConfiguration() -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .dontCare, // Good
                                               graphType: .forceEnter, // Good
                                               guidesType: .forceEnter, // Good
                                               phoneExpandedTopType: .forceEnter, // Good
                                               phoneExpandedBottomType: .dontCare, // Good
                                               timeLineType: .dontCare, // Good
                                               animationLoopType: .dontCare, // Good
                                               animationContinuousType: .dontCare, // Good
                                               animationLoopsPageType: .dontCare, // Good
                                               animationTimeLinePageType: .dontCare, // Good
                                               animationContinuousPageType: .dontCare, // Good
                                               timeLineSwatchType: .dontCare, // Good
                                               jigglePointTanType: .dontCare, // Good
                                               guidePointTanType: .dontCare) // Good
        return result
    }
    
}
