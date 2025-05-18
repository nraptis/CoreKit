//
//  CreatorMode.swift
//  TypeKit
//
//  Created by Nicholas Raptis on 5/9/25.
//

import Foundation

@frozen public enum CreatorMode: UInt8 {
    case none
    case makeJiggle
    case drawJiggle
    case addJigglePoint
    case deleteJigglePoint
    case makeGuide
    case drawGuide
    case addGuidePoint
    case deleteGuidePoint
    case moveJiggleCenter
    case moveGuideCenter
}
