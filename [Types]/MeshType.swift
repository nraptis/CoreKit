//
//  MeshType.swift
//  TypeKit
//
//  Created by Nicholas Raptis on 5/9/25.
//

import Foundation

@frozen public enum MeshType: UInt8 {
    case none
    case standardForced
    case standardIfNeeded
    case weightsForced
    case weightsIfNeeded
    case affineOnlyStandard
    case affineOnlyWeights
    case weightsOnly
}
