//
//  HistoryStateGenerateTopography.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/17/25.
//

import Foundation

public class HistoryStateGenerateTopography: HistoryState {
    
    public let startDatas: [Data]
    public let endDatas: [Data]
    public let startWeightCenter: Math.Point
    public let endWeightCenter: Math.Point
    public let jiggleIndex: Int
    public let weightCurveIndex: Int?
    public init(jiggleIndex: Int,
                weightCurveIndex: Int?,
                startDatas: [Data],
                endDatas: [Data],
                startWeightCenter: Math.Point,
                endWeightCenter: Math.Point) {
        self.jiggleIndex = jiggleIndex
        self.weightCurveIndex = weightCurveIndex
        self.startDatas = startDatas
        self.endDatas = endDatas
        self.startWeightCenter = startWeightCenter
        self.endWeightCenter = endWeightCenter
        super.init(.generateTopography)
    }
    
    public override func getWorldConfiguration() -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .dontCare, // Good
                                               graphType: .forceLeave, // Good
                                               guidesType: .forceEnter, // Good
                                               phoneExpandedTopType: .dontCare, // Good
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
