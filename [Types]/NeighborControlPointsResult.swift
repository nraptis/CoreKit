//
//  NeighborControlPointsResult.swift
//  TypeKit
//
//  Created by Nicholas Raptis on 5/9/25.
//

import Foundation

@frozen public enum NeighborControlPointsResult: UInt8 {
    case notDirectNeighbor
    case neighborToTheRight
    case neighborToTheLeft
}
