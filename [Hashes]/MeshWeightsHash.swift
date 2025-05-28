//
//  JiggleMeshGuideHash.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 7/8/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public struct MeshWeightsHash: Equatable {
    
    public init() {
        
    }
    
    public var polyHash = PolyHash()
    var guideOutlineHashes = [OutlineHashGuide]()
    var guideCenterX = Float(-100_000.0)
    var guideCenterY = Float(-100_000.0)
    var isDarkMode = false
    public mutating func change(polyHash: PolyHash,
                         guideOutlineHashes: [OutlineHashGuide],
                         guideCenterX: Float,
                         guideCenterY: Float,
                         isDarkMode: Bool) {
        self.polyHash = polyHash
        self.guideOutlineHashes = guideOutlineHashes
        self.guideCenterX = guideCenterX
        self.guideCenterY = guideCenterY
        self.isDarkMode = isDarkMode
    }
    
    public mutating func invalidate() {
        polyHash.invalidate()
    }
}
