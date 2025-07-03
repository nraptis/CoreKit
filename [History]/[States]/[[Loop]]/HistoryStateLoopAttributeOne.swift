//
//  HistoryStateLoopAttributeSingle.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/3/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public class HistoryStateLoopAttributeOne: HistoryState {
    
    public let jiggleIndex: Int
    public let startAttribute: LoopAttribute
    public let endAttribute: LoopAttribute
    public let selectedTimeLineSwatch: Swatch
    public let pageType: HistoryWorldConfiguration.ThreePageType
    public init(jiggleIndex: Int,
                    startAttribute: LoopAttribute,
                    endAttribute: LoopAttribute,
                    selectedTimeLineSwatch: Swatch,
                interfaceConfiguration: any InterfaceConfigurationConforming,
                pageType: HistoryWorldConfiguration.ThreePageType) {
        self.jiggleIndex = jiggleIndex
        self.startAttribute = startAttribute
        self.endAttribute = endAttribute
        self.selectedTimeLineSwatch = selectedTimeLineSwatch
        self.pageType = pageType
        super.init(historyStateType: .loopAttributeOne,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    static func getTimeLineType(loopAttributeType: LoopAttributeType,
                                selectedTimeLineSwatch: Swatch,
                                creationInterfaceConfiguration: any InterfaceConfigurationConforming) -> HistoryWorldConfiguration.TimeLineType {
        
        let timeLineType: HistoryWorldConfiguration.TimeLineType
        switch loopAttributeType {
        case .timeLineDuration:
            timeLineType = .forceLeave
        case .timeLineFrameOffset:
            timeLineType = .forceEnter
        case .timeLineSwatchX:
            timeLineType = .forceEnter
        case .timeLineSwatchY:
            timeLineType = .forceEnter
        case .timeLineSwatchScale:
            timeLineType = .forceEnter
        case .timeLineSwatchRotation:
            timeLineType = .forceEnter
        case .timeLine:
            if creationInterfaceConfiguration.isTimeLineEnabled {
                timeLineType = .forceEnter
            } else {
                timeLineType = .dontCare
            }
        }
        
        return timeLineType
    }
    
    static func getSwatchType(loopAttributeType: LoopAttributeType,
                              selectedTimeLineSwatch: Swatch) -> HistoryWorldConfiguration.TimeLineSwatchType {
        let timeLineSwatchType: HistoryWorldConfiguration.TimeLineSwatchType
        switch loopAttributeType {
        case .timeLineDuration:
            timeLineSwatchType = .dontCare
        case .timeLineFrameOffset:
            timeLineSwatchType = .exact(selectedTimeLineSwatch)
        case .timeLineSwatchX:
            timeLineSwatchType = .exact(.x)
        case .timeLineSwatchY:
            timeLineSwatchType = .exact(.y)
        case .timeLineSwatchScale:
            timeLineSwatchType = .exact(.scale)
        case .timeLineSwatchRotation:
            timeLineSwatchType = .exact(.rotation)
        case .timeLine:
            timeLineSwatchType = .dontCare
        }
        return timeLineSwatchType
    }
    
    static func getTopMenuType(loopAttributeType: LoopAttributeType) -> HistoryWorldConfiguration.ExpandedType {
        let topMenuType: HistoryWorldConfiguration.ExpandedType
        switch loopAttributeType {
        case .timeLineDuration:
            topMenuType = .dontCare
        case .timeLineFrameOffset:
            topMenuType = .dontCare
        case .timeLineSwatchX:
            topMenuType = .forceEnter
        case .timeLineSwatchY:
            topMenuType = .forceEnter
        case .timeLineSwatchScale:
            topMenuType = .forceEnter
        case .timeLineSwatchRotation:
            topMenuType = .forceEnter
        case .timeLine:
            topMenuType = .forceEnter
        }
        return topMenuType
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        
        let loopAttributeType: LoopAttributeType
        loopAttributeType = startAttribute.loopAttributeType
        let timeLineType = HistoryStateLoopAttributeOne.getTimeLineType(loopAttributeType: loopAttributeType,
                                                                        selectedTimeLineSwatch: selectedTimeLineSwatch,
                                                                        creationInterfaceConfiguration: creationInterfaceConfiguration)
        let timeLineSwatchType = HistoryStateLoopAttributeOne.getSwatchType(loopAttributeType: loopAttributeType,
                                                                            selectedTimeLineSwatch: selectedTimeLineSwatch)
        let topMenuType = HistoryStateLoopAttributeOne.getTopMenuType(loopAttributeType: loopAttributeType)
        let result = HistoryWorldConfiguration(documentMode: .view, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .dontCare, // Good
                                               graphType: .dontCare, // Good
                                               guidesType: .dontCare, // Good
                                               jigglePointTanType: .dontCare, // Good
                                               guidePointTanType: .dontCare, // Good
                                               phoneExpandedTopType: topMenuType, // Good
                                               timeLineType: timeLineType, // Good
                                               animationLoopType: .forceEnter, // Good
                                               animationContinuousType: .forceLeave, // Good
                                               animationLoopsPageType: .dontCare, // Good
                                               animationTimeLinePageType: pageType, // Good
                                               animationContinuousPageType: .dontCare, // Good
                                               timeLineSwatchType: timeLineSwatchType) // Good
        return result
    }
    
}
