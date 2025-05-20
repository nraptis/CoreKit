//
//  ContinuousAttributeDataUserDurationGroup.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public struct ContinuousAttributeDataUserDurationGroup {
    public let duration: Float
    public let angle: Float
    public let power: Float
    public init(duration: Float, angle: Float, power: Float) {
        self.duration = duration
        self.angle = angle
        self.power = power
    }
}
