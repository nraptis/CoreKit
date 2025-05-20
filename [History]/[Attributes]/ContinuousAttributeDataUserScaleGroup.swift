//
//  ContinuousAttributeDataUserScaleGroup.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public struct ContinuousAttributeDataUserScaleGroup {
    public let startScale: Float
    public let endScale: Float
    public let frameOffset: Float
    public init(startScale: Float, endScale: Float, frameOffset: Float) {
        self.startScale = startScale
        self.endScale = endScale
        self.frameOffset = frameOffset
    }
}
