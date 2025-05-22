//
//  KillDragReleaseSource.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 5/21/25.
//

import Foundation

@frozen public enum KillDragReleaseSource: UInt8 {
    case internalCancelAction
    case gestureHandOverZoomModeCancel
    case gestureHandOverPreciseMagnifiedBoxCancel
    case gestureHandOverPreciseDistantBoxCancel
    case gestureHandOverNormalBoxCancel
    case gestureMovementTriggeredCancel
    case touchesEndedNormalBox
    case touchesEndedPreciseMagnifiedBox
    case touchesEndedPreciseDistantBox
    case usingGestureCancellingTouches
    case usingDragCancellingGestures
}
