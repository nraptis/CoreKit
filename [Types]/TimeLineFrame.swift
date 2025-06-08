//
//  TimeLineFrame.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 6/2/25.
//

import Foundation

public struct TimeLineFrame {
    public let width: Float
    public let height: Float
    public let paddingH: Float
    public let paddingV: Float
    public init(width: Float,
                height: Float,
                paddingH: Float,
                paddingV: Float) {
        self.width = width
        self.height = height
        self.paddingH = paddingH
        self.paddingV = paddingV
    }
}

