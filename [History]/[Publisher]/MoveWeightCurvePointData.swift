//
//  MoveWeightCurvePointData.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/18/25.
//

import Foundation

struct MoveWeightCurvePointData {
    var jiggleIndex: Int?
    var weightCurveIndex: Int?
    var startManual = false
    var startHeightFactor = Float(0.0)
    var endHeightFactor = Float(0.0)
    var didChange = false
}
