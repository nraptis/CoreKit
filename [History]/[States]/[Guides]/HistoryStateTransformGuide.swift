//
//  HistoryStateTransformGuide.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public class HistoryStateTransformGuide: HistoryState {
    
    public let jiggleIndex: Int
    public let guideIndex: Int
    public let startCenter: Math.Point
    public let startScale: Float
    public let startRotation: Float
    public let endCenter: Math.Point
    public let endScale: Float
    public let endRotation: Float
    public init(jiggleIndex: Int,
                guideIndex: Int,
                startCenter: Math.Point,
                startScale: Float,
                startRotation: Float,
                endCenter: Math.Point,
                endScale: Float,
                endRotation: Float,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.guideIndex = guideIndex
        self.startCenter = startCenter
        self.startScale = startScale
        self.startRotation = startRotation
        self.endCenter = endCenter
        self.endScale = endScale
        self.endRotation = endRotation
        super.init(historyStateType: .transformGuide,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .dontCare, // Good
                                               graphType: .forceLeave, // Good
                                               guidesType: .forceEnter, // Good
                                               jigglePointTanType: .dontCare, // TODO TODO TODO TODO
                                               guidePointTanType: .dontCare, // TODO TODO TODO TODO
                                               phoneExpandedTopType: .dontCare, // Good
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
