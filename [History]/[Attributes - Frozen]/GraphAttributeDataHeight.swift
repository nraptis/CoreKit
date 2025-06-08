//
//  GraphAttributeDataHeight.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 6/2/25.
//

import Foundation

public struct GraphAttributeDataHeight {
    
    public let normalizedHeightFactor: Float
    public let isManualHeightEnabled: Bool
    
    public init(normalizedHeightFactor: Float, isManualHeightEnabled: Bool) {
        self.normalizedHeightFactor = normalizedHeightFactor
        self.isManualHeightEnabled = isManualHeightEnabled
    }
}
