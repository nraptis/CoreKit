//
//  InterfaceConfigurationConforming.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 5/21/25.
//

import Foundation

public protocol InterfaceConfigurationConforming {
    var isVideoRecordModeEnabled: Bool { get set }
    var isVideoExportModeEnabled: Bool { get set }
    var isGraphModeEnabled: Bool { get set }
    var isZoomEnabled: Bool { get set }
    var isGuidesEnabled: Bool { get set }
    
    var isJigglePointTansEnabled: Bool { get set }
    var isGuidePointTansEnabled: Bool { get set }
    
    
    var isAnimationLoopsEnabled: Bool { get set }
    var isAnimationContinuousEnabled: Bool { get set }
    var isTimeLineEnabled: Bool { get set }
    var isPreciseModeEnabled: Bool { get set }
    var isRenderOptionsEnabled: Bool { get set }
    var documentMode: DocumentMode { get set }
    var editMode: EditMode { get set }
    var creatorMode: CreatorMode { get set }
    var weightMode: WeightMode { get set }
    //var pointSelectionModality: PointSelectionModality { get set }
    //var selectedTimeLineSwatch: Swatch { get set }
    
    var animationLoopsPage: Int { get set }
    var animationTimeLinePage: Int { get set }
    var animationContinuousPage: Int { get set }
    var graphPage: Int { get set }
    //var isExpanded: Bool { get set }
    
    var isExpandedTop: Bool { get set }
    var isExpandedBottom: Bool { get set }
    
    mutating func prepare(disableCreatorModes: Bool)
    
    mutating func ensureConsistency(disableCreatorModes: Bool)
    mutating func calculateHeightCategories()
    
    func isRightOf(_ configuration: any InterfaceConfigurationConforming) -> Bool
}
