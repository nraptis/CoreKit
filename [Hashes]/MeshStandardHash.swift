//
//  JiggleMeshStandardHash.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 7/8/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public struct MeshStandardHash: Equatable {
    
    public init() {
        
    }
    
    public var polyHash = PolyHash()
    public var isDarkMode = false
    public mutating func change(polyHash: PolyHash,
                         isDarkMode: Bool) {
        self.polyHash = polyHash
        self.isDarkMode = isDarkMode
    }
}
