//
//  InterfaceConfigurationPhone.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 6/10/25.
//

import Foundation

public struct InterfaceConfigurationPhone {
    
    public var toolMenuPage = ToolMenuPage.uninitialized
    
    //public var heightCategoryTop = MenuHeightCategoryPhoneTop.standard
    //public var heightCategoryBottom = MenuHeightCategoryPhoneBottom.standard
    //public var isExpanded = true // *NOT USED*
    public var isExpandedTop = true
    public var isExpandedBottom = true
    public var isVideoRecordModeEnabled = false
    public var isVideoExportModeEnabled = false
    public var isGraphModeEnabled = false
    public var isZoomEnabled = false
    public var isGuidesEnabled = false
    
    public var isJigglePointTansEnabled = false
    public var isGuidePointTansEnabled = false
    
    public var isAnimationLoopsEnabled = false
    public var isAnimationContinuousEnabled = false
    public var isTimeLineEnabled = false
    public var isPreciseModeEnabled = false
    public var isRenderOptionsEnabled = false
    public var animationLoopsPage = 0
    public var animationTimeLinePage = 0
    public var animationContinuousPage = 0
    public var graphPage = 0
    public var documentMode = DocumentMode.edit
    public var editMode = EditMode.jiggles
    public var weightMode = WeightMode.guides
    public var creatorMode = CreatorMode.none
    //public var pointSelectionModality = PointSelectionModality.points
    //public var selectedTimeLineSwatch = Swatch.x
    
    public init() {
        
    }
    
    public mutating func calculateMenuPage() {
        if isVideoExportModeEnabled {
            toolMenuPage = .videoExport
        } else if isVideoRecordModeEnabled {
            toolMenuPage = .videoRecord
        } else if isZoomEnabled {
            toolMenuPage = .zoom
        } else {
            switch documentMode {
            case .view:
                if isAnimationLoopsEnabled {
                    if isTimeLineEnabled {
                        toolMenuPage = .timeLine
                    } else {
                        toolMenuPage = .standard
                    }
                } else {
                    toolMenuPage = .standard
                }
            case .edit:
                if isGuidesEnabled {
                    if isGraphModeEnabled {
                        toolMenuPage = .graph
                    } else {
                        toolMenuPage = .standard
                    }
                } else {
                    toolMenuPage = .standard
                }
            }
        }
    }
}
