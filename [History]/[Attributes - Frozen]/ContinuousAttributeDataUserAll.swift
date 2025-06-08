//
//  ContinuousAttributeDataUserAll.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public struct ContinuousAttributeDataUserAll {
    public let duration: Float
    public let angle: Float
    public let power: Float
    public let swoop: Float
    public let wiggle: Float
    public let frameOffset: Float
    public let startScale: Float
    public let endScale: Float
    public let startRotation: Float
    public let endRotation: Float
    public init(duration: Float,
                angle: Float,
                power: Float,
                swoop: Float,
                wiggle: Float,
                frameOffset: Float,
                startScale: Float,
                endScale: Float,
                startRotation: Float,
                endRotation: Float) {
        self.duration = duration
        self.angle = angle
        self.power = power
        self.swoop = swoop
        self.wiggle = wiggle
        self.frameOffset = frameOffset
        self.startScale = startScale
        self.endScale = endScale
        self.startRotation = startRotation
        self.endRotation = endRotation
    }
}
