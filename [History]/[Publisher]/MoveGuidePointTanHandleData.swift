//
//  MoveGuidePointTanHandleData.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/17/25.
//

import Foundation

struct MoveGuidePointTanHandleData {
    var jiggleIndex: Int?
    var guideIndex: Int?
    var guidePointIndex: Int?
    var tanType = TanType.in
    var didChange = false
    var startData = ControlPointData()
    var endData = ControlPointData()    
}
