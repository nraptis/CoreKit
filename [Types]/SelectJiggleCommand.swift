//
//  SelectJiggleCommand.swift
//  TypeKit
//
//  Created by Nicholas Raptis on 5/10/25.
//

import Foundation

public struct SelectJiggleCommand {
    public let isJiggleCenterFirstPriority: Bool
    public let isFrozenIncluded: Bool
    public init(isJiggleCenterFirstPriority: Bool, isFrozenIncluded: Bool) {
        self.isJiggleCenterFirstPriority = isJiggleCenterFirstPriority
        self.isFrozenIncluded = isFrozenIncluded
    }
}
