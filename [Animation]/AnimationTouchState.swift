//
//  AnimationTouchSkeleton.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/8/24.
//

import UIKit

class AnimationTouchState {
    init(x: Float,
         y: Float,
         touchID: ObjectIdentifier) {
        self.x = x
        self.y = y
        self.touchID = touchID
    }
    var x: Float
    var y: Float
    var touchID: ObjectIdentifier
}
