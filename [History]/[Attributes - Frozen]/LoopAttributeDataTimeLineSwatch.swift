//
//  LoopAttributeDataTimeLineSwatch.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public struct LoopAttributeDataTimeLineSwatch {
    public let swatch: Swatch
    public let selectedSwatch: Swatch
    public let selectedChannelIndex: Int
    public let frameOffset: Float
    public let channelDataList: [LoopAttributeDataTimeLineChannel]
    public init(swatch: Swatch,
                selectedSwatch: Swatch,
                selectedChannelIndex: Int,
                frameOffset: Float,
                channelDataList: [LoopAttributeDataTimeLineChannel]) {
        self.swatch = swatch
        self.selectedSwatch = selectedSwatch
        self.selectedChannelIndex = selectedChannelIndex
        self.frameOffset = frameOffset
        self.channelDataList = channelDataList
    }
}

