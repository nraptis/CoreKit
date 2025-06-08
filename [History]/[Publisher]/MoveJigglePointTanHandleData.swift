//
//  MoveJigglePointTanHandleData.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/17/25.
//

import Foundation

struct MoveJigglePointTanHandleData {
    var jiggleIndex: Int?
    var tanType = TanType.in
    var controlPointIndex: Int?
    var didChange = false
    var startData = ControlPointData()
    var endData = ControlPointData()
}
