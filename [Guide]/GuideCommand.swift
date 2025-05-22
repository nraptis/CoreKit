//
//  GuideCommand.swift
//  TypeKit
//
//  Created by Nicholas Raptis on 5/9/25.
//

import Foundation

public struct GuideCommand {
    
    public init(spline: Bool,
                outlineType: ForceableType) {
        self.spline = spline
        self.outlineType = outlineType
    }
    
    public static var none: GuideCommand {
        GuideCommand(spline: false, outlineType: .ifNeeded)
    }
    
    public let spline: Bool
    public let outlineType: ForceableType
    
}

