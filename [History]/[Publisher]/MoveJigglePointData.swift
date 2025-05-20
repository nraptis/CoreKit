//
//  MoveJigglePointData.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/17/25.
//

import Foundation
import CoreKit

struct MoveJigglePointData {
    var startPoint = Math.Point.zero
    var endPoint = Math.Point.zero
    var jiggleIndex: Int?
    var controlPointIndex: Int?
    var didChange = false
}
