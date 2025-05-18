//
//  JigglePolyHash.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 7/8/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public struct PolyHash: Equatable {
    
    public init() {
        
    }
    
    public var splineHash = SplineHash()
    public var triangulationType = TriangulationType.none
    public mutating func change(splineHash: SplineHash,
                         triangulationType: TriangulationType) {
        self.splineHash = splineHash
        self.triangulationType = triangulationType
    }
}
