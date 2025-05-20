//
//  MoveGuidePointData.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/17/25.
//

import Foundation
import CoreKit

struct MoveGuidePointData {
    var startPoint = Math.Point.zero
    var endPoint = Math.Point.zero
    var jiggleIndex: Int?
    var guideIndex: Int?
    var guidePointIndex: Int?
    var didChange = false
}
