//
//  WeightGraphStorageNode.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 5/30/25.
//

import Foundation

public struct WeightGraphStorageNode {
    public let startHeightManual: Bool
    public let startHeightFactor: Float
    public let startTangentManual: Bool
    public let startDirection: Float
    public let startMagnitudeIn: Float
    public let startMagnitudeOut: Float
    public init(startHeightManual: Bool,
                startHeightFactor: Float,
                startTangentManual: Bool,
                startDirection: Float,
                startMagnitudeIn: Float,
                startMagnitudeOut: Float) {
        self.startHeightManual = startHeightManual
        self.startHeightFactor = startHeightFactor
        self.startTangentManual = startTangentManual
        self.startDirection = startDirection
        self.startMagnitudeIn = startMagnitudeIn
        self.startMagnitudeOut = startMagnitudeOut
    }
}
