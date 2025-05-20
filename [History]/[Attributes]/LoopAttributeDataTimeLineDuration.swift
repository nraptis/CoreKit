//
//  LoopAttributeDataTimeLineDuration.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public struct LoopAttributeDataTimeLineDuration {
    public let duration: Float
    public let selectedSwatch: Swatch
    public init(duration: Float, selectedSwatch: Swatch) {
        self.duration = duration
        self.selectedSwatch = selectedSwatch
    }
}
