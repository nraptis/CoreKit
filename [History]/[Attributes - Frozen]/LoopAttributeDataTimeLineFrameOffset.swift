//
//  LoopAttributeDataTimeLineFrameOffset.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public struct LoopAttributeDataTimeLineFrameOffset {
    public let frameOffset: Float
    public let selectedSwatch: Swatch
    public init(frameOffset: Float,
                selectedSwatch: Swatch) {
        self.frameOffset = frameOffset
        self.selectedSwatch = selectedSwatch
    }
}
