//
//  LoopAttributeDataTimeLine.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public struct LoopAttributeDataTimeLine {
    public let swatchDataX: LoopAttributeDataTimeLineSwatch
    public let swatchDataY: LoopAttributeDataTimeLineSwatch
    public let swatchDataScale: LoopAttributeDataTimeLineSwatch
    public let swatchDataRotation: LoopAttributeDataTimeLineSwatch
    public let duration: Float
    public init(swatchDataX: LoopAttributeDataTimeLineSwatch,
                swatchDataY: LoopAttributeDataTimeLineSwatch,
                swatchDataScale: LoopAttributeDataTimeLineSwatch,
                swatchDataRotation: LoopAttributeDataTimeLineSwatch,
                duration: Float) {
        self.swatchDataX = swatchDataX
        self.swatchDataY = swatchDataY
        self.swatchDataScale = swatchDataScale
        self.swatchDataRotation = swatchDataRotation
        self.duration = duration
    }
}
