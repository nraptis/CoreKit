//
//  MoveJiggleCenterData.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/17/25.
//

import Foundation

struct MoveJiggleCenterData {
    var startCenter = Math.Point.zero
    var endCenter = Math.Point.zero
    var jiggleIndex: Int?
    var didChange = false
}
