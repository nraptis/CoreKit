//
//  MoveWeightCurveTanHandleData.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/18/25.
//

import Foundation

struct MoveWeightCurveTanHandleData {
    var jiggleIndex: Int?
    var weightCurveIndex: Int?
    var startManual = false
    var startDirection = Float(0.0)
    var startMagnitudeIn = Float(0.0)
    var startMagnitudeOut = Float(0.0)
    var endDirection = Float(0.0)
    var endMagnitudeIn = Float(0.0)
    var endMagnitudeOut = Float(0.0)
    var didChange = false
}
