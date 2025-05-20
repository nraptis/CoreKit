//
//  HistoryWorldConfiguration.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 5/15/24.
//

import Foundation

public struct HistoryWorldConfiguration {
    
    @frozen public enum TimeLineType: UInt8 {
        case forceEnter
        case forceLeave
        case dontCare
    }
    
    @frozen public enum TimeLineSwatchType {
        case exact(Swatch)
        case dontCare
    }
    
    @frozen public enum AnimationLoopType: UInt8 {
        case forceEnter
        case forceLeave
        case dontCare
    }
    
    @frozen public enum AnimationContinuousType: UInt8 {
        case forceEnter
        case forceLeave
        case dontCare
    }
    
    @frozen public enum TwoPageType: UInt8 {
        case forcePage1
        case forcePage2
        case dontCare
    }
    
    @frozen public enum ThreePageType: UInt8 {
        case forcePage1
        case forcePage2
        case forcePage3
        case dontCare
    }
    
    @frozen public enum GraphType: UInt8 {
        case forceEnter
        case forceLeave
        case dontCare
    }
    
    @frozen public enum GuidesType: UInt8 {
        case forceEnter
        case forceLeave
        case dontCare
    }
    
    @frozen public enum ExpandedType: UInt8 {
        case forceEnter
        case dontCare
    }
    
    @frozen public enum EditModeType {
        case forceEnter(EditMode)
        case dontCare
    }
    
    @frozen public enum DisplayModeType {
        case forceEnter(DisplayMode)
        case dontCare
    }
    
    @frozen public enum WeightModeType {
        case forceEnter(WeightMode)
        case dontCare
    }
    
    @frozen public enum JigglePointTanType: UInt8 {
        case forceEnter
        case forceLeave
        case dontCare
    }
    
    @frozen public enum GuidePointTanType: UInt8 {
        case forceEnter
        case forceLeave
        case dontCare
    }
    
    public let documentMode: DocumentMode
    public let editModeType: EditModeType
    public let weightModeType: WeightModeType
    public var graphType: GraphType
    public var guidesType: GuidesType
    public var phoneExpandedTopType: ExpandedType
    public var phoneExpandedBottomType: ExpandedType
    public var timeLineType: TimeLineType
    public var animationLoopType: AnimationLoopType
    public var animationContinuousType: AnimationContinuousType
    public var animationLoopsPageType: ThreePageType
    public var animationTimeLinePageType: ThreePageType
    public var animationContinuousPageType: ThreePageType
    public let timeLineSwatchType: TimeLineSwatchType
    public let jigglePointTanType: JigglePointTanType
    public let guidePointTanType: GuidePointTanType
    
    public init(documentMode: DocumentMode,
         editModeType: EditModeType,
         weightModeType: WeightModeType,
         graphType: GraphType,
         guidesType: GuidesType,
         phoneExpandedTopType: ExpandedType,
         phoneExpandedBottomType: ExpandedType,
         timeLineType: TimeLineType,
         animationLoopType: AnimationLoopType,
         animationContinuousType: AnimationContinuousType,
         animationLoopsPageType: ThreePageType,
         animationTimeLinePageType: ThreePageType,
         animationContinuousPageType: ThreePageType,
         timeLineSwatchType: TimeLineSwatchType,
         jigglePointTanType: JigglePointTanType,
         guidePointTanType: GuidePointTanType) {
        
        self.documentMode = documentMode
        self.editModeType = editModeType
        self.weightModeType = weightModeType
        self.graphType = graphType
        self.guidesType = guidesType
        self.phoneExpandedTopType = phoneExpandedTopType
        self.phoneExpandedBottomType = phoneExpandedBottomType
        self.timeLineType = timeLineType
        self.animationLoopType = animationLoopType
        self.animationContinuousType = animationContinuousType
        self.animationLoopsPageType = animationLoopsPageType
        self.animationTimeLinePageType = animationTimeLinePageType
        self.animationContinuousPageType = animationContinuousPageType
        self.timeLineSwatchType = timeLineSwatchType
        self.jigglePointTanType = jigglePointTanType
        self.guidePointTanType = guidePointTanType
    }
}
