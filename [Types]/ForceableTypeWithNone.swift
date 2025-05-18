//
//  ForceableTypeWithNone.swift
//  TypeKit
//
//  Created by Nicholas Raptis on 5/9/25.
//

import Foundation

@frozen public enum ForceableTypeWithNone: UInt8 {
    case none
    case forced
    case ifNeeded
}
